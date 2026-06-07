import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

/// Provider سراسری دیتابیس.
/// همه ماژول‌ها از طریق این provider به دیتابیس دسترسی دارند.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
