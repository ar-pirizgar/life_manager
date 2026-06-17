import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

int _daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;

class LoanRepository {
  LoanRepository(this._db);
  final AppDatabase _db;

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

      for (int i = 0; i < totalInstallments; i++) {
        final number = i + 1;
        final rawMonth = startDate.month + i;
        final year = startDate.year + (rawMonth - 1) ~/ 12;
        final month = ((rawMonth - 1) % 12) + 1;

        final daysInMon = _daysInMonth(year, month);
        final dueDay = dueDayOfMonth.clamp(1, daysInMon);
        final dueDate = DateTime(year, month, dueDay);

        final DateTime reminderDate;
        if (reminderDayOfMonth <= dueDayOfMonth) {
          final remDay = reminderDayOfMonth.clamp(1, daysInMon);
          reminderDate = DateTime(year, month, remDay);
        } else {
          final prevMonth = month == 1 ? 12 : month - 1;
          final prevYear = month == 1 ? year - 1 : year;
          final daysInPrev = _daysInMonth(prevYear, prevMonth);
          final remDay = reminderDayOfMonth.clamp(1, daysInPrev);
          reminderDate = DateTime(prevYear, prevMonth, remDay);
        }

        final isPaid = number <= paidInstallments;

        await _db.into(_db.loanInstallments).insert(LoanInstallmentsCompanion(
              id: Value(_uuid.v4()),
              loanId: Value(loanId),
              installmentNumber: Value(number),
              month: Value(month),
              year: Value(year),
              amount: Value(installmentAmount),
              dueDate: Value(dueDate),
              reminderDate: Value(reminderDate),
              status: Value(isPaid ? 'paid' : 'pending'),
              paidAt: Value(isPaid ? dueDate : null),
            ));
      }
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
