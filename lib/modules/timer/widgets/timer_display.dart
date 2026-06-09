import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({
    super.key,
    required this.elapsed,
    required this.isRunning,
  });

  final Duration elapsed;
  final bool isRunning;

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primaryContainer,
        border: Border.all(
          color: isRunning ? colors.primary : colors.outlineVariant,
          width: isRunning ? 3 : 1,
        ),
        boxShadow: isRunning
            ? [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        _format(elapsed),
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
      ),
    );
  }
}
