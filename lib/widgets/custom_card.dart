import 'package:gdscapp/index.dart';

class CustomCard extends Card {
  final Widget child;
  final Color? color;
  final double? paddings;
  final double? margins;
  final double? width;
  final double? height;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.paddings,
    this.margins,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.8,
      height: height,
      padding: EdgeInsets.all(paddings ?? 10),
      child: Card(
          elevation: 5,
          color: color ?? colorScheme.surface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child:
              Container(margin: EdgeInsets.all(margins ?? 10), child: child)),
    );
  }
}
