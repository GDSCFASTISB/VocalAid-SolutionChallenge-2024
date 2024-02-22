import 'package:gdscapp/index.dart';

class CustomCard extends Card {
  final Widget child;
  final Color? colorn;
  final double? paddings;
  final double? margins;
  final double? width;
  final double? height;
  final double? elevation;
  final bool? border;

  const CustomCard({
    super.key,
    required this.child,
    this.colorn,
    this.paddings,
    this.margins,
    this.width,
    this.height,
    this.elevation,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height,
      padding: EdgeInsets.all(paddings ?? 10),
      child: Card(
          elevation: elevation ?? 1,
          color: colorn ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: border ?? false
                ? BorderSide(color: colorScheme.primary, width: 1.0)
                : const BorderSide(color: Colors.transparent, width: 0),
          ),
          child:
              Container(margin: EdgeInsets.all(margins ?? 10), child: child)),
    );
  }
}
