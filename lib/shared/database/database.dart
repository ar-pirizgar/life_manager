import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// ============================================================
// جداول دیتابیس
// هر ماژول جداول خودش را اینجا تعریف می‌کند.
// برای اضافه کردن ماژول جدید، فقط جدول جدید را اضافه کنید
// و schemaVersion را افزایش دهید.
// ============================================================

// --- ماژول اهداف ---

class LongGoals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  // active | completed | paused
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ShortGoals extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get longGoalId =>
      text().nullable().references(LongGoals, #id)();
  DateTimeColumn get deadline => dateTime().nullable()();
  // active | completed
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// --- ماژول تسک‌ها ---

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  // تاریخ انجام تسک
  DateTimeColumn get dueDate => dateTime()();
  // لینک اختیاری به هدف کوتاه‌مدت
  TextColumn get shortGoalId =>
      text().nullable().references(ShortGoals, #id)();
  // برچسب/دسته‌بندی آزاد
  TextColumn get category => text().nullable()();
  TextColumn get notes => text().nullable()();
  // pending | done | cancelled
  TextColumn get status => text().withDefault(const Constant('pending'))();
  // آیا این تسک به‌صورت خودکار توسط یک عادت ساخته شده؟
  TextColumn get habitId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ============================================================
// تعریف دیتابیس
// ============================================================

@DriftDatabase(tables: [LongGoals, ShortGoals, Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // نسخه schema — هنگام اضافه/تغییر جدول این عدد را زیاد کنید
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // در آپدیت‌های بعدی، migration ماژول‌های جدید اینجا اضافه می‌شود
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'life_manager.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
