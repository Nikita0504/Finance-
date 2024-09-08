import 'package:finance/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CircularChart extends StatelessWidget {
  final double totalAmount;
  final Map<String, double> categories;
  final double visibleBalance;

  CircularChart(
      {required this.totalAmount,
      required this.categories,
      required this.visibleBalance});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 100,
          child: CustomPaint(
            size: Size(200, 200),
            painter: CircularChartPainter(
                totalAmount: totalAmount, categories: categories),
          ),
        ),
        Positioned(
          top: 175,
          child: Text(
            'Total amount\n$visibleBalance ₽',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ],
    );
  }
}

class CircularChartPainter extends CustomPainter {
  final double totalAmount;
  final Map<String, double> categories;

  CircularChartPainter({required this.totalAmount, required this.categories});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width / 2, size.height / 2);
    final center = Offset(size.width / 2, size.height / 2);

    if (totalAmount == 0) {
      // Если баланс равен 0, рисуем серый круг
      final paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 15;

      canvas.drawCircle(center, radius, paint);
    } else {
      double startAngle = -pi / 2; // Начальный угол -90 градусов

      for (var entry in categories.entries) {
        final sweepAngle = (entry.value / totalAmount) * 2 * pi;
        final paint = Paint()
          ..color = _getColorForCategory(entry.key)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 15;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          paint,
        );

        startAngle += sweepAngle; // Обновляем начальный угол
      }
    }
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'loss':
        return Colors.red;
      case 'purpose':
        return Colors.blue;
      case 'expenses':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
