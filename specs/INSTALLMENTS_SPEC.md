# Installments & Debts Module — Feature Spec

## Overview

این ماژول برای مدیریت وام‌ها، خریدهای قسطی، کارت‌های اعتباری و هر نوع بدهی قسطی طراحی شده.
هدف: کاربر همیشه بداند چه قسطی، چه موقع، و به چه مبلغی باید پرداخت کند.

---

## Placement

در Finance Module به عنوان یک Tab مجزا کنار Transactions و Financial Goals اضافه شود.

```
Finance Screen Tabs:
[ Transactions ] [ Installments ] [ Goals ]
```

---

## Data Models

### Debt (وام / بدهی)

```dart
class Debt {
  final int id;
  final String title;           // عنوان (مثلاً "وام خودرو")
  final DebtType type;          // نوع بدهی
  final double totalAmount;     // مبلغ کل
  final double installmentAmount; // مبلغ هر قسط
  final int totalInstallments;  // تعداد کل اقساط
  final int paidInstallments;   // تعداد اقساط پرداخت شده
  final int dueDayOfMonth;      // موعد واقعی قسط (مثلاً 25)
  final int reminderDayOfMonth; // روز یادآوری در Tasks (مثلاً 1)
  final DateTime startDate;     // تاریخ شروع
  final DebtStatus status;      // وضعیت کلی وام
}
```

#### DebtType enum
```dart
enum DebtType {
  bankLoan,       // وام بانکی
  installmentPurchase, // خرید قسطی
  creditCard,     // کارت اعتباری
  personalDebt,   // قرض شخصی
  other,          // سایر
}
```

#### DebtStatus enum
```dart
enum DebtStatus {
  active,
  completed,
  cancelled,
}
```

---

### DebtInstallment (هر قسط)

```dart
class DebtInstallment {
  final int id;
  final int debtId;
  final int installmentNumber;  // شماره قسط (1، 2، 3، ...)
  final int month;              // ماه (1-12)
  final int year;               // سال
  final double amount;          // مبلغ این قسط
  final DateTime dueDate;       // موعد واقعی پرداخت
  final DateTime reminderDate;  // تاریخ یادآوری (روزی که Task ساخته میشه)
  final InstallmentStatus status;
  final DateTime? paidAt;       // تاریخ واقعی پرداخت (null اگه نپرداخته)
  final int? taskId;            // ارجاع به Task مربوطه (اگه Task ساخته شده)
}
```

#### InstallmentStatus enum
```dart
enum InstallmentStatus {
  pending,   // هنوز نرسیده یا نپرداخته
  paid,      // پرداخت شده (با تایید کاربر)
  overdue,   // موعد گذشته و هنوز پرداخت نشده
}
```

---

## Database Tables

### `debts` table

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PK | |
| title | TEXT | عنوان وام |
| type | TEXT | DebtType |
| total_amount | REAL | مبلغ کل |
| installment_amount | REAL | مبلغ هر قسط |
| total_installments | INTEGER | تعداد کل اقساط |
| paid_installments | INTEGER | تعداد پرداخت شده (auto-updated) |
| due_day_of_month | INTEGER | موعد واقعی (1-31) |
| reminder_day_of_month | INTEGER | روز یادآوری (1-31) |
| start_date | TEXT | ISO date |
| status | TEXT | DebtStatus |
| created_at | TEXT | |
| updated_at | TEXT | |

### `debt_installments` table

| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER PK | |
| debt_id | INTEGER FK | ارجاع به debts |
| installment_number | INTEGER | شماره قسط |
| month | INTEGER | ماه |
| year | INTEGER | سال |
| amount | REAL | مبلغ |
| due_date | TEXT | موعد واقعی |
| reminder_date | TEXT | تاریخ یادآوری |
| status | TEXT | InstallmentStatus |
| paid_at | TEXT | تاریخ پرداخت (nullable) |
| task_id | INTEGER | FK به tasks (nullable) |
| created_at | TEXT | |

---

## Business Logic

### ۱. ساخت وام جدید

وقتی کاربر وام جدید ثبت می‌کند:

1. رکورد `Debt` ذخیره شود.
2. به صورت خودکار برای تمام اقساط آینده رکورد `DebtInstallment` ساخته شود.
3. `reminderDate` هر قسط = روز `reminderDayOfMonth` از همان ماه قسط.
4. اگه `reminderDayOfMonth` کوچک‌تر از `dueDayOfMonth` باشه → یادآوری همان ماه.
5. اگه کاربر اقساط قبلی پرداخت شده داشته باشد (وام قدیمی)، می‌تواند `paidInstallments` را موقع ثبت وارد کند.

### ۲. تولید خودکار Task

هر روز صبح (یا هنگام باز شدن اپ)، سیستم بررسی کند:

```
برای هر DebtInstallment با status = pending:
  اگه reminderDate == امروز AND taskId == null:
    → یک Task جدید بساز با:
       title: "پرداخت قسط: {debt.title}"
       dueDate: reminderDate
       type: installmentPayment (یا یک فیلد مشخص برای تمایز)
       linkedInstallmentId: installment.id
    → taskId را در installment ذخیره کن
```

### ۳. تیک زدن Task = تایید پرداخت

وقتی کاربر Task مربوط به قسط را complete می‌کند:

```
1. installment.status = paid
2. installment.paidAt = DateTime.now()
3. یک Transaction جدید ثبت شود:
   - amount: installment.amount
   - type: expense
   - category: "پرداخت قسط"
   - description: "قسط {number} — {debt.title}"
   - date: DateTime.now()
4. debt.paidInstallments += 1
5. اگه paidInstallments == totalInstallments → debt.status = completed
```

### ۴. پرداخت زودتر از موعد (از داخل Finance)

کاربر می‌تواند از صفحه جزئیات وام، هر قسط pending را دستی پرداخت کند:

```
1. همان مراحل بالا (۱ تا ۵) اجرا شود
2. اگه Task مربوط به آن قسط هنوز ساخته نشده → ساخته نشود
3. اگه Task قبلاً ساخته شده → آن Task هم completed شود
```

### ۵. Overdue شدن

یک بار در روز (یا هنگام باز شدن اپ):

```
برای هر DebtInstallment با status = pending:
  اگه dueDate < امروز:
    → installment.status = overdue
    → اگه Task مربوطه وجود دارد → Task هم overdue شود
```

### ۶. قوانین کلی

- حذف Debt → اقساط حذف شوند، اما Transactions مربوطه **حذف نشوند**
- Timer Overlap: اگه قسطی paid شد، دیگر Task جدیدی برای آن ماه ساخته نمی‌شود
- `paidInstallments` همیشه از روی جدول `debt_installments` محاسبه شود (نه hardcode)

---

## UI Screens

### Screen 1: Installments List

**آدرس:** Finance > Tab "Installments"

**Summary Cards (بالای صفحه، دو کارت):**
- کل بدهی فعال (مجموع مانده همه وام‌های active)
- قسط این ماه (مجموع اقساط pending این ماه)

**لیست وام‌ها:**

هر کارت شامل:
- عنوان وام + نوع
- Badge وضعیت:
  - 🔴 "عقب‌افتاده" — اگه installment overdue داشته باشد
  - 🟡 "این هفته" — اگه reminderDate این هفته باشد
  - 🟢 "به موقع" — بقیه حالات
- Progress bar: `paidInstallments / totalInstallments`
- شمارنده: "X از Y قسط"
- قسط بعدی: مبلغ + تاریخ یادآوری
- اگه overdue: دکمه "ثبت پرداخت" مستقیم روی کارت

---

### Screen 2: Debt Detail

**آدرس:** Installments List > tap روی یک وام

**اطلاعات وام:**
- مانده بدهی (محاسبه: `(totalInstallments - paidInstallments) * installmentAmount`)
- مبلغ هر قسط
- موعد واقعی قسط
- روز یادآوری در Tasks
- تعداد اقساط مانده

**تاریخچه اقساط:**

لیست تمام اقساط به ترتیب نزولی (جدیدترین اول):
- اقساط overdue: border قرمز + دکمه "ثبت پرداخت"
- اقساط paid: badge سبز + تاریخ واقعی پرداخت + نوشته "زودتر از موعد" اگه `paidAt < dueDate`
- اقساط pending آینده: نمایش تاریخ یادآوری

---

### Screen 3: Add/Edit Debt Form

**فیلدها:**

| فیلد | نوع | توضیح |
|------|-----|-------|
| عنوان | TextInput | الزامی |
| نوع | Dropdown | DebtType |
| مبلغ کل | NumberInput | الزامی |
| مبلغ هر قسط | NumberInput | الزامی |
| تعداد کل اقساط | NumberInput | الزامی |
| اقساط پرداخت شده | NumberInput | پیش‌فرض: 0 |
| موعد واقعی قسط | DayPicker (1-31) | الزامی |
| روز یادآوری در Tasks | DayPicker (1-31) | الزامی |
| تاریخ شروع | DatePicker | الزامی |

**نکته UI:** فیلد "روز یادآوری در Tasks" با رنگ آبی هایلایت شود و زیرش توضیح کوتاه: "یک Task خودکار این روز ساخته می‌شود"

---

## Design Tokens

از همان Design System پروژه استفاده شود:

```
Primary Color: #2563EB
Success: #22C55E
Warning: #F59E0B
Danger: #EF4444
Border Radius: 8, 12, 16
Font: Inter
```

---

## Feature Flags

این فیچر بخشی از **Wave 2** roadmap است (Reality Tracking System).
جدول `debts` قبلاً در database schema تعریف شده — این پیاده‌سازی آن است.

---

## Out of Scope (فعلاً)

- نوتیفیکیشن (در Wave بعدی اضافه می‌شود)
- محاسبه سود وام
- چند ارز
- یادآوری روزهای متعدد برای یک قسط

---

*این spec توسط کاربر و Claude تهیه شده — تاریخ: دی ۱۴۰۳*
