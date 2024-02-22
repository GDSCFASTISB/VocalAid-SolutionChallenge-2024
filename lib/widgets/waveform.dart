import 'package:flutter/material.dart';

class WaveformPainter extends CustomPainter {
  final List<double> waveform;
  final double maxHeight; // Maximum height above and below the center

  WaveformPainter(this.waveform, {this.maxHeight = 50.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Find the maximum absolute value in the waveform for normalization
    double maxAbsValue = waveform.fold(
        0.0,
        (currentMax, value) =>
            value.abs() > currentMax ? value.abs() : currentMax);

    Path path = Path();
    double centerY = size.height / 2;
    double step = size.width / waveform.length;

    // Start the path in the middle of the Y axis
    path.moveTo(0, centerY);

    for (int i = 0; i < waveform.length; i++) {
      double x = i * step;
      // Normalize the waveform value to fit within the maxHeight
      double normalizedValue =
          (waveform[i] / maxAbsValue) * maxHeight; // Normalization
      double y = centerY - normalizedValue;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
