import 'package:flutter/material.dart';

/// صفحه موقت برای ماژول‌هایی که هنوز ساخته نشده‌اند.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.phase,
  });

  final String title;
  final IconData icon;
  final String phase;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Text(
              'این بخش در $phase ساخته می‌شود',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
