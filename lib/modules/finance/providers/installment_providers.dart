import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/database/database.dart';
import '../../../shared/database/database_provider.dart';

const _uuid = Uuid();

// ─── Enums ────────────────────────────────────────────────────

enum LoanType {
  bankLoan('bank_loan', 'وام بانکی'),
  installmentPurchase('installment_purchase', 'خرید قسطی'),
  creditCard('credit_card', 'کارت اعتباری'),
  personalDebt('personal_debt', 'قرض شخصی'),
  other('other', 'سایر');

  const LoanType(this.key, this.label);
  final String key;
  final String label;

  static LoanType fromKey(String key) => LoanType.values.firstWhere(
        (e) => e.key == key,
        orElse: () => LoanType.other,
      );
}

enum LoanStatus {
  active('active', 'فعال'),
  completed('completed', 'تمام شده'),
  cancelled('cancelled', 'لغو شده');

  const LoanStatus(this.key, this.label);
  final String key;
  final String label;

  static LoanStatus fromKey(String key) => LoanStatus.values.firstWhere(
        (e) => e.key == key,
        orElse: () => LoanStatus.active,
      );
}

enum InstallmentPaymentStatus {
  pending('pending', 'در انتظار'),
  paid('paid', 'پرداخت شده'),
  overdue('overdue', 'عقب افتاده');

  const InstallmentPaymentStatus(this.key, this.label);
  final String key;
  final String label;

  static InstallmentPaymentStatus fromKey(String key) =>
      InstallmentPaymentStatus.values.firstWhere(
        (e) => e.key == key,
        orElse: () => InstallmentPaymentStatus.pending,
      );
}

// ─── Repository ──────────────────────────────────────────────


Jalali _nextJalaliMonth(Jalali j) {
  final rawMonth = j.month + 1;
  return Jalali(j.year + (rawMonth - 1) ~/ 12, ((rawMonth - 1) % 12) + 1, 1);
}

class LoanRepository {
  LoanRepository(this._db);
  final AppDatabase _db;

  // Generates and inserts installment rows for [loanId] from index [fromIndex]
  // (0-based) up to [totalInstallments - 1].
  Future<void> _insertInstallments({
    required String loanId,
    required int fromIndex,
    required int totalInstallments,
    required double installmentAmount,
    required int dueDayOfMonth,
    required int reminderDayOfMonth,
    required Jalali jStart,
    required bool markAsPaid,
  }) async {
    for (int i = fromIndex; i < totalInstallments; i++) {
      final number = i + 1;
      final rawMonth = jStart.month + i;
      final jYear = jStart.year + (rawMonth - 1) ~/ 12;
      final jMonth = ((rawMonth - 1) % 12) + 1;

      final monthLength = Jalali(jYear, jMonth, 1).monthLength;
      final dueDay = dueDayOfMonth.clamp(1, monthLength);
      final dueDate = Jalali(jYear, jMonth, dueDay).toDateTime();

      final DateTime reminderDate;
      if (reminderDayOfMonth <= dueDayOfMonth) {
        final remDay = reminderDayOfMonth.clamp(1, monthLength);
        reminderDate = Jalali(jYear, jMonth, remDay).toDateTime();
      } else {
        // reminder falls in the previous Shamsi month
        final prevJMonth = jMonth == 1 ? 12 : jMonth - 1;
        final prevJYear = jMonth == 1 ? jYear - 1 : jYear;
        final prevMonthLength = Jalali(prevJYear, prevJMonth, 1).monthLength;
        final remDay = reminderDayOfMonth.clamp(1, prevMonthLength);
        reminderDate = Jalali(prevJYear, prevJMonth, remDay).toDateTime();
      }

      await _db.into(_db.loanInstallments).insert(LoanInstallmentsCompanion(
            id: Value(_uuid.v4()),
            loanId: Value(loanId),
            installmentNumber: Value(number),
            month: Value(jMonth),
            year: Value(jYear),
            amount: Value(installmentAmount),
            dueDate: Value(dueDate),
            reminderDate: Value(reminderDate),
            status: Value(markAsPaid ? 'paid' : 'pending'),
            paidAt: Value(markAsPaid ? dueDate : null),
          ));
    }
  }

  Future<void> createLoan({
    required String title,
    required LoanType type,
    required double totalAmount,
    required double installmentAmount,
    required int totalInstallments,
    required int paidInstallments,
    required int dueDayOfMonth,
    required int reminderDayOfMonth,
    required DateTime startDate,
  }) async {
    final loanId = _uuid.v4();
    final jStart = Jalali.fromDateTime(startDate);
    await _db.transaction(() async {
      await _db.into(_db.installmentLoans).insert(InstallmentLoansCompanion(
            id: Value(loanId),
            title: Value(title),
            type: Value(type.key),
            totalAmount: Value(totalAmount),
            installmentAmount: Value(installmentAmount),
            totalInstallments: Value(totalInstallments),
            paidInstallments: Value(paidInstallments),
            dueDayOfMonth: Value(dueDayOfMonth),
            reminderDayOfMonth: Value(reminderDayOfMonth),
            startDate: Value(startDate),
          ));

      // Paid installments (already settled before entry)
      await _insertInstallments(
        loanId: loanId,
        fromIndex: 0,
        totalInstallments: paidInstallments,
        installmentAmount: installmentAmount,
        dueDayOfMonth: dueDayOfMonth,
        reminderDayOfMonth: reminderDayOfMonth,
        jStart: jStart,
        markAsPaid: true,
      );

      // Future unpaid installments.
      // If the reminder day in the start month falls before the loan start day,
      // the first reminder has already passed before the loan begins — advance by one month.
      final unpaidJStart = (paidInstallments == 0 && reminderDayOfMonth < jStart.day)
          ? _nextJalaliMonth(jStart)
          : jStart;
      await _insertInstallments(
        loanId: loanId,
        fromIndex: paidInstallments,
        totalInstallments: totalInstallments,
        installmentAmount: installmentAmount,
        dueDayOfMonth: dueDayOfMonth,
        reminderDayOfMonth: reminderDayOfMonth,
        jStart: unpaidJStart,
        markAsPaid: false,
      );
    });
  }

  Future<void> updateLoan({
    required String loanId,
    required String title,
    required LoanType type,
    required double totalAmount,
    required double installmentAmount,
    required int totalInstallments,
    required int dueDayOfMonth,
    required int reminderDayOfMonth,
    required DateTime startDate,
  }) async {
    final jStart = Jalali.fromDateTime(startDate);
    await _db.transaction(() async {
      // Count actual paid installments from existing records
      final paidRecords = await (_db.select(_db.loanInstallments)
            ..where((i) =>
                i.loanId.equals(loanId) & i.status.equals('paid')))
          .get();
      final paidCount = paidRecords.length;

      // Delete all unpaid installments and their linked tasks
      final unpaid = await (_db.select(_db.loanInstallments)
            ..where((i) =>
                i.loanId.equals(loanId) &
                i.status.isNotIn(const ['paid'])))
          .get();
      for (final inst in unpaid) {
        if (inst.taskId != null) {
          await (_db.delete(_db.tasks)
                ..where((t) => t.id.equals(inst.taskId!)))
              .go();
        }
      }
      await (_db.delete(_db.loanInstallments)
            ..where((i) =>
                i.loanId.equals(loanId) &
                i.status.isNotIn(const ['paid'])))
          .go();

      // Update loan record
      final isComplete = paidCount >= totalInstallments;
      await (_db.update(_db.installmentLoans)
            ..where((l) => l.id.equals(loanId)))
          .write(InstallmentLoansCompanion(
            title: Value(title),
            type: Value(type.key),
            totalAmount: Value(totalAmount),
            installmentAmount: Value(installmentAmount),
            totalInstallments: Value(totalInstallments),
            paidInstallments: Value(paidCount),
            dueDayOfMonth: Value(dueDayOfMonth),
            reminderDayOfMonth: Value(reminderDayOfMonth),
            startDate: Value(startDate),
            status: Value(isComplete ? 'completed' : 'active'),
            updatedAt: Value(DateTime.now()),
          ));

      // Regenerate future installments.
      final updateUnpaidJStart = (paidCount == 0 && reminderDayOfMonth < jStart.day)
          ? _nextJalaliMonth(jStart)
          : jStart;
      await _insertInstallments(
        loanId: loanId,
        fromIndex: paidCount,
        totalInstallments: totalInstallments,
        installmentAmount: installmentAmount,
        dueDayOfMonth: dueDayOfMonth,
        reminderDayOfMonth: reminderDayOfMonth,
        jStart: updateUnpaidJStart,
        markAsPaid: false,
      );
    });
  }

  Future<void> markInstallmentPaid(LoanInstallment installment) async {
    if (installment.status == 'paid') return;
    final loan = await _db.getLoanById(installment.loanId);
    if (loan == null) return;

    await _db.transaction(() async {
      await (_db.update(_db.loanInstallments)
            ..where((i) => i.id.equals(installment.id)))
          .write(LoanInstallmentsCompanion(
            status: const Value('paid'),
            paidAt: Value(DateTime.now()),
          ));

      await _db.into(_db.transactions).insert(TransactionsCompanion(
            id: Value(_uuid.v4()),
            title: Value('پرداخت قسط: ${loan.title}'),
            amount: Value(installment.amount),
            type: const Value('expense'),
            category: const Value('installment_payment'),
            notes: Value(
                'قسط ${installment.installmentNumber} — ${loan.title}'),
            date: Value(DateTime.now()),
          ));

      final newPaidCount = loan.paidInstallments + 1;
      final isComplete = newPaidCount >= loan.totalInstallments;
      await (_db.update(_db.installmentLoans)
            ..where((l) => l.id.equals(loan.id)))
          .write(InstallmentLoansCompanion(
            paidInstallments: Value(newPaidCount),
            status: Value(isComplete ? 'completed' : 'active'),
            updatedAt: Value(DateTime.now()),
          ));

      if (installment.taskId != null) {
        await (_db.update(_db.tasks)
              ..where((t) => t.id.equals(installment.taskId!)))
            .write(TasksCompanion(
              status: const Value('done'),
              completedAt: Value(DateTime.now()),
            ));
      }
    });
  }

  Future<void> deleteLoan(String loanId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.loanInstallments)
            ..where((i) => i.loanId.equals(loanId)))
          .go();
      await (_db.delete(_db.installmentLoans)
            ..where((l) => l.id.equals(loanId)))
          .go();
    });
  }

  Future<void> syncInstallmentsState() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    // 1. Mark overdue: pending installments past due date
    final pending = await _db.getPendingInstallments();
    for (final i in pending) {
      final dueStart =
          DateTime(i.dueDate.year, i.dueDate.month, i.dueDate.day);
      if (dueStart.isBefore(todayStart)) {
        await (_db.update(_db.loanInstallments)
              ..where((inst) => inst.id.equals(i.id)))
            .write(const LoanInstallmentsCompanion(status: Value('overdue')));
      }
    }

    // 2. Auto-create tasks for today's reminders
    final pendingNoTask = await (_db.select(_db.loanInstallments)
          ..where((i) => i.status.equals('pending') & i.taskId.isNull()))
        .get();

    for (final inst in pendingNoTask) {
      final remStart = DateTime(inst.reminderDate.year,
          inst.reminderDate.month, inst.reminderDate.day);
      if (remStart == todayStart) {
        final loan = await _db.getLoanById(inst.loanId);
        if (loan == null) continue;
        final taskId = _uuid.v4();
        await _db.into(_db.tasks).insert(TasksCompanion(
              id: Value(taskId),
              title: Value('پرداخت قسط: ${loan.title}'),
              dueDate: Value(inst.reminderDate),
              category: const Value('installment_payment'),
              notes: Value('installment:${inst.id}'),
              priority: const Value('high'),
            ));
        await (_db.update(_db.loanInstallments)
              ..where((i) => i.id.equals(inst.id)))
            .write(LoanInstallmentsCompanion(taskId: Value(taskId)));
      }
    }

    // 3. Sync: if linked task is done → mark installment paid
    final withTask = await (_db.select(_db.loanInstallments)
          ..where((i) =>
              (i.status.equals('pending') | i.status.equals('overdue')) &
              i.taskId.isNotNull()))
        .get();

    for (final inst in withTask) {
      final taskId = inst.taskId;
      if (taskId == null) continue;
      final task = await (_db.select(_db.tasks)
            ..where((t) => t.id.equals(taskId)))
          .getSingleOrNull();
      if (task != null && task.status == 'done') {
        await markInstallmentPaid(inst);
      }
    }
  }
}

// ─── Providers ────────────────────────────────────────────────

final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  return LoanRepository(ref.watch(databaseProvider));
});

final activeLoansProvider = StreamProvider<List<InstallmentLoan>>((ref) {
  return ref.watch(databaseProvider).watchActiveLoans();
});

final loanByIdProvider =
    StreamProvider.family<InstallmentLoan?, String>((ref, id) {
  return ref.watch(databaseProvider).watchLoanById(id);
});

final loanInstallmentsProvider =
    StreamProvider.family<List<LoanInstallment>, String>((ref, loanId) {
  return ref.watch(databaseProvider).watchLoanInstallments(loanId);
});

final allPendingInstallmentsProvider =
    StreamProvider<List<LoanInstallment>>((ref) {
  return ref.watch(databaseProvider).watchAllPendingInstallments();
});
