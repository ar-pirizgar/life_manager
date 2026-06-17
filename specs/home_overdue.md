# Spec: Overdue Tasks + Sort Order + Remove Priority Dots

## تغییر ۱ — حذف نقطه‌های اولویت
نقطه‌های زیر pill اولویت (priority dots) رو کاملاً حذف کن — نه widget، نه فضا.

## تغییر ۲ — ترتیب لیست تسک‌های امروز
لیست تسک‌های Home رو به این ترتیب sort کن:
1. Overdue (dueDate قبل از امروز، انجام‌نشده)
2. اولویت بالا (امروز، انجام‌نشده)
3. اولویت متوسط (امروز، انجام‌نشده)
4. اولویت پایین (امروز، انجام‌نشده)
5. همه‌ی انجام‌شده‌ها (صرف‌نظر از اولویت)

## تغییر ۳ — تسک‌های Overdue

### رنگ جدید در AppColors
```dart
static const Color overdue = Color(0xFFC026D3);
```

### Provider
provider تسک‌های Home رو طوری تغییر بده که تسک‌های overdue
(dueDate < امروز و status != completed) هم نمایش داده بشن.

### کارت Overdue
- همون ساختار _TaskCard فعلی
- پس‌زمینه: نسخه‌ی خیلی تیره‌ی AppColors.overdue (opacity ~8%)
- border: نسخه‌ی تیره‌ی AppColors.overdue (opacity ~35%)
- هاله‌ی RadialGradient: با AppColors.overdue (opacity ~13%)
- pill اولویت: رنگ اولویت خودش (نه overdue) — نشون داده بشه
- زیر عنوان تسک، به‌جای ساعت، متن فارسی: «X روز پیش»
  که X = تعداد روزهای گذشته از dueDate تا امروز

## در آخر
flutter analyze بزن و خطاها رو برطرف کن.
