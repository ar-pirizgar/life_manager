import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

/// Provider سراسری دیتابیس.
/// همه ماژول‌ها از طریق این provider به دیتابیس دسترسی دارند.
// Always overridden in main() with a pre-constructed AppDatabase(dbPath).
final databaseProvider = Provider<AppDatabase>((ref) {
  throw StateError('databaseProvider must be overridden in main()');
});
