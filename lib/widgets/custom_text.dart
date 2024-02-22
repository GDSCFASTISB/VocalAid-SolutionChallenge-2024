import '../index.dart';

class CustomText extends Text {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight})
      : super('');

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        height: 1,
        fontSize: fontSize ?? 20,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
      ),
    );
  }
}
