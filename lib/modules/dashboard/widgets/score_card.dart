import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../shared/utils/jalali_helper.dart';

Color _scoreColor(double score) {
  if (score >= 70) return const Color(0xFF22C55E);
  if (score >= 40) return const Color(0xFFF59E0B);
  return const Color(0xFFEF4444);
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.title,
    required this.score,
  });

  final String title;
  final double score;

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor(score);
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: _RingPainter(
                      progress: score / 100,
                      color: color,
                      bg: colors.surfaceContainerHighest,
                    ),
                  ),
                  Center(
                    child: Text(
                      JalaliHelper.toFa(score.round().toString()),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.bg,
  });

  final double progress;
  final Color color;
  final Color bg;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = math.min(cx, cy) - 6;
    const stroke = 6.0;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    final bgPaint = Paint()
      ..color = bg
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi, false, bgPaint);
    canvas.drawArc(
        rect, -math.pi / 2, 2 * math.pi * progress.clamp(0, 1), false, fgPaint);
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}
