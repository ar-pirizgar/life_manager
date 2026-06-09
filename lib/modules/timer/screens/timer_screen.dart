import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/timer_providers.dart';
import '../widgets/category_picker.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_log_tile.dart';

class TimerScreen extends ConsumerWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerNotifierProvider);
    final notifier = ref.read(timerNotifierProvider.notifier);
    final isIdle = timer.status == TimerStatus.idle;

    return Scaffold(
      appBar: AppBar(
        title: const Text('تایمر'),
        actions: [
          if (!isIdle)
            TextButton(
              onPressed: notifier.discard,
              child: Text(
                'لغو',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, _) {
              final t = ref.watch(timerNotifierProvider);
              return CategoryPicker(
                selected: t.category,
                onSelected: notifier.setCategory,
                enabled: t.status == TimerStatus.idle,
              );
            },
          ),
          const SizedBox(height: 40),
          Consumer(
            builder: (context, ref, _) {
              final t = ref.watch(timerNotifierProvider);
              return TimerDisplay(
                elapsed: t.elapsed,
                isRunning: t.status == TimerStatus.running,
              );
            },
          ),
          const SizedBox(height: 40),
          _ControlButtons(
            status: timer.status,
            onStart: notifier.start,
            onPause: notifier.pause,
            onStop: notifier.stop,
          ),
          const SizedBox(height: 32),
          const Divider(height: 1),
          Expanded(
            child: ref.watch(todayTimeLogsProvider).when(
                  data: (logs) => _LogsList(logs: logs),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
          ),
        ],
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onStop,
  });

  final TimerStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final Future<void> Function() onStop;

  @override
  Widget build(BuildContext context) {
    if (status == TimerStatus.idle) {
      return FilledButton.icon(
        onPressed: onStart,
        icon: const Icon(Icons.play_arrow),
        label: const Text('شروع'),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (status == TimerStatus.running)
          OutlinedButton.icon(
            onPressed: onPause,
            icon: const Icon(Icons.pause),
            label: const Text('مکث'),
          )
        else
          FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow),
            label: const Text('ادامه'),
          ),
        const SizedBox(width: 16),
        FilledButton.icon(
          onPressed: onStop,
          icon: const Icon(Icons.stop),
          label: const Text('ذخیره'),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
        ),
      ],
    );
  }
}

class _LogsList extends ConsumerWidget {
  const _LogsList({required this.logs});

  final List<dynamic> logs;

  String _formatTotal(int seconds) {
    final d = Duration(seconds: seconds);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h > 0) return '$h ساعت $m دقیقه';
    if (m > 0) return '$m دقیقه';
    return '$seconds ثانیه';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'هنوز جلسه‌ای ثبت نشده',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    final total = ref.watch(todayTotalSecondsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              Text(
                'امروز',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                _formatTotal(total),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, i) => TimerLogTile(log: logs[i]),
          ),
        ),
      ],
    );
  }
}
