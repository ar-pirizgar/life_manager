import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بیشتر')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _MoreTile(
            icon: Icons.timer_outlined,
            title: 'تایمر',
            subtitle: 'ردیابی زمان و کار عمیق',
            onTap: () => context.go('/more/timer'),
          ),
          const SizedBox(height: 8),
          _MoreTile(
            icon: Icons.loop_outlined,
            title: 'عادت‌ها',
            subtitle: 'پیگیری عادت‌های روزانه',
            onTap: () => context.go('/more/habits'),
          ),
          const SizedBox(height: 8),
          const _MoreTile(
            icon: Icons.dashboard_outlined,
            title: 'داشبورد',
            subtitle: 'آمار و تحلیل عملکرد',
            comingSoon: true,
          ),
          const SizedBox(height: 8),
          const _MoreTile(
            icon: Icons.settings_outlined,
            title: 'تنظیمات',
            subtitle: 'تنظیمات اپلیکیشن',
            comingSoon: true,
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.comingSoon = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: comingSoon
                ? colors.surfaceContainerHighest
                : colors.primaryContainer,
          ),
          child: Icon(
            icon,
            color: comingSoon
                ? colors.onSurfaceVariant
                : colors.onPrimaryContainer,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: comingSoon
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'به‌زودی',
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              )
            : Icon(Icons.chevron_right, color: colors.onSurfaceVariant),
        onTap: onTap,
      ),
    );
  }
}
