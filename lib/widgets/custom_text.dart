import '../index.dart';

class CustomText extends Text {
  final String text;
  final Color? color;
  final double? fontSize;

  const CustomText({super.key, required this.text, this.color, this.fontSize})
      : super('');

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black,
      ),
    );
  }
}
