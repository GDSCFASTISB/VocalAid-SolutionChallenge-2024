import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final List<double> waveform;

  WaveformPainter(this.waveform);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    double centerY = size.height / 2;
    double step = size.width / waveform.length;

    path.moveTo(0, centerY);

    for (int i = 0; i < waveform.length; i++) {
      double x = i * step;
      double y = (centerY - waveform[i] * 20 * centerY);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveformDisplay extends StatelessWidget {
  final List<double> waveform;

  WaveformDisplay(this.waveform);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveformPainter(waveform),
      size: Size(double.infinity, 100), // Adjust size according to your needs
    );
  }
}
