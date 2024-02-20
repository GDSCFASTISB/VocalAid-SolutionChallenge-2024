import 'dart:math';
import 'package:flutter/material.dart';
// Assuming GoogleFonts and CustomText are correctly imported

class AnimatedCircularProgressWidget extends StatefulWidget {
  final double accuracy;
  final String? label;
  final double? size;

  const AnimatedCircularProgressWidget({
    Key? key,
    required this.accuracy,
    this.label,
    this.size,
  }) : super(key: key);

  @override
  _AnimatedCircularProgressWidgetState createState() =>
      _AnimatedCircularProgressWidgetState();
}

class _AnimatedCircularProgressWidgetState
    extends State<AnimatedCircularProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _accuracyAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _accuracyAnimation = Tween<double>(
      begin: 0,
      end: widget.accuracy,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {}); // This forces a rebuild whenever the animation changes
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressWidget(
      accuracy: _accuracyAnimation.value,
      label: widget.label ?? "Accuracy",
      size: widget.size,
    );
  }
}

class CircularProgressWidget extends StatelessWidget {
  final double accuracy;
  final String label;
  final double? size;

  const CircularProgressWidget({
    required this.accuracy,
    required this.label,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    double effectiveSize =
        size ?? 100.0; // Use the provided size or default to 100.0

    return Column(children: [
      Stack(children: [
        Container(
          width: effectiveSize,
          height: effectiveSize,
          child: CustomPaint(
            painter: ContinuousProgressPainter(accuracy: accuracy),
            size: Size(effectiveSize, effectiveSize),
          ),
        ),
        Container(
          width: effectiveSize,
          height: effectiveSize,
          alignment: Alignment.center, // Center the text within the container
          child: Text(
            "${accuracy.toInt()}%",
            style: TextStyle(
              fontSize: 0.2 *
                  effectiveSize, // Dynamically adjust the font size based on the container size
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ]),
      Visibility(
        visible: label != "",
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(label),
        ),
      )
    ]);
  }
}

class ContinuousProgressPainter extends CustomPainter {
  final double accuracy;

  ContinuousProgressPainter({required this.accuracy});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accuracy <= 30
          ? Colors.red
          : accuracy <= 60
              ? Colors.orange
              : Colors.green
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width /
          15 // Adjust the stroke width based on the size of the widget
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - paint.strokeWidth / 2;
    final arcAngle = 2 * pi * (accuracy / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
