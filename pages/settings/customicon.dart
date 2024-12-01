import 'package:flutter/material.dart';

class CustomSwitchIcon extends StatelessWidget {
  final double size;
  final Color color;

  CustomSwitchIcon({this.size = 24.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _SwitchIconPainter(color),
    );
  }
}

class _SwitchIconPainter extends CustomPainter {
  final Color color;

  _SwitchIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Draw the first square
    path.moveTo(size.width * 0.2, size.height * 0.2);
    path.lineTo(size.width * 0.4, size.height * 0.2);
    path.lineTo(size.width * 0.4, size.height * 0.4);
    path.lineTo(size.width * 0.2, size.height * 0.4);
    path.close();

    // Draw the arrow connecting first to second square
    path.moveTo(size.width * 0.4, size.height * 0.3);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.55, size.height * 0.25);
    path.moveTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.55, size.height * 0.35);

    // Draw the second square
    path.moveTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width * 0.8, size.height * 0.6);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width * 0.6, size.height * 0.8);
    path.close();

    // Draw the arrow connecting second to first square
    path.moveTo(size.width * 0.6, size.height * 0.7);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.45, size.height * 0.65);
    path.moveTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.45, size.height * 0.75);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
