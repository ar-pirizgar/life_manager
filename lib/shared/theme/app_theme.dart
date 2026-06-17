import 'package:flutter/material.dart';

/// توکن‌های رنگی مرکزی اپ — فقط dark mode.
/// هیچ رنگی نباید مستقیم در صفحه‌ها هاردکد شود؛ از این کلاس استفاده کن.
class AppColors {
  AppColors._();

  // پس‌زمینه و سطوح
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceVariant = Color(0xFF1C1C1C);
  static const Color border = Color(0xFF232323);

  // متن
  static const Color textPrimary = Color(0xFFF5F0E8);
  static const Color textSecondary = Color(0xFF9A958C);
  static const Color textMuted = Color(0xFF6E6E73);

  // برند
  static const Color primary = Color(0xFF8B7BE8);

  // اولویت تسک
  static const Color priorityCritical = Color(0xFFE24035);
  static const Color priorityHigh = Color(0xFFE01814);
  static const Color priorityMedium = Color(0xFFD6C535);
  static const Color priorityLow = Color(0xFF3F8ADD);

  // عادت‌ها / موفقیت
  static const Color success = Color(0xFF2E8B45);
  static const Color successAccent = Color(0xFF5DCB7A);

  // اکشن‌های مالی
  static const Color financeGreen = Color(0xFF3FB68B);

  // کارت تسک انجام‌شده
  static const Color doneCardBackground = Color(0xFF1A1A1A);
  static const Color doneCardBorder = Color(0xFF2A2A2A);

  // تسک‌های overdue
  static const Color overdue = Color(0xFFC026D3);

  /// رنگ متناظر با مقدار اولویت تسک
  static Color priorityFor(String priority) => switch (priority) {
        'critical' => priorityCritical,
        'high' => priorityHigh,
        'medium' => priorityMedium,
        _ => priorityLow,
      };
}

/// تم اپلیکیشن — dark-only.
/// هر دو getter به همان تم تاریک اشاره می‌کنند؛
/// در main.dart هر دو تنظیم می‌شوند تا سیستم‌عامل‌های مختلف
/// از تم صحیح استفاده کنند.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _build();
  static ThemeData get dark => _build();

  static ThemeData _build() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.successAccent,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFF0C2010),
      onSecondaryContainer: AppColors.successAccent,
      error: AppColors.priorityCritical,
      onError: Colors.white,
      errorContainer: const Color(0xFF3B0A08),
      onErrorContainer: AppColors.priorityCritical,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      surfaceContainerLow: AppColors.surface,
      surfaceContainerHighest: AppColors.surfaceVariant,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Vazirmatn',
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Vazirmatn',
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Vazirmatn',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        tileColor: AppColors.surface,
        textColor: AppColors.textPrimary,
        iconColor: AppColors.textSecondary,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primary.withValues(alpha: 0.15),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const WidgetStatePropertyAll(
          IconThemeData(color: AppColors.textMuted),
        ),
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 12,
            color: AppColors.textMuted,
            fontFamily: 'Vazirmatn',
          ),
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textMuted,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Vazirmatn',
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: 'Vazirmatn',
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.textPrimary),
        displayMedium: TextStyle(color: AppColors.textPrimary),
        displaySmall: TextStyle(color: AppColors.textPrimary),
        headlineLarge: TextStyle(color: AppColors.textPrimary),
        headlineMedium: TextStyle(color: AppColors.textPrimary),
        headlineSmall:
            TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: AppColors.textPrimary),
        titleMedium: TextStyle(color: AppColors.textPrimary),
        titleSmall: TextStyle(color: AppColors.textSecondary),
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
        bodySmall: TextStyle(color: AppColors.textMuted),
        labelLarge: TextStyle(color: AppColors.textPrimary),
        labelMedium: TextStyle(color: AppColors.textSecondary),
        labelSmall: TextStyle(color: AppColors.textMuted),
      ),
    );
  }
}
