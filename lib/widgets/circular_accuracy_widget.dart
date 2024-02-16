import '../index.dart';

class AnimatedCircularProgressWidget extends StatefulWidget {
  final double accuracy;

  const AnimatedCircularProgressWidget({
    super.key,
    required this.accuracy,
  });
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
      end: widget.accuracy, // Set the final accuracy value
    ).animate(_animationController);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _accuracyAnimation,
      builder: (context, child) {
        return CircularProgressWidget(
          accuracy: _accuracyAnimation.value,
          label: "Accuracy",
        );
      },
    );
  }
}

class CircularProgressWidget extends StatelessWidget {
  final double accuracy;
  final String label;

  const CircularProgressWidget({required this.accuracy, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Container(
          width: 100.0,
          height: 100.0,
          child: CustomPaint(
            painter: ContinuousProgressPainter(accuracy: accuracy),
          ),
        ),
        Container(
          width: 100.0,
          height: 100.0,
          child: Center(
            child: Text(
              "${accuracy.toInt()}",
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ]),
      const CustomText(text: "Accuracy")
    ]);
  }
}

class ContinuousProgressPainter extends CustomPainter {
  final double accuracy;

  ContinuousProgressPainter({required this.accuracy});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - paint.strokeWidth / 2;

    final double arcAngle = 2 * pi * (accuracy / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from the top
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
