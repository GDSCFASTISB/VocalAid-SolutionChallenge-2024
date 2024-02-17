import 'package:gdscapp/index.dart';

class CustomCard extends Card {
  final Widget child;
  final Color? color;
  final double? paddings;
  final double? margins;

  const CustomCard(
      {super.key,
      required this.child,
      this.color,
      this.paddings,
      this.margins});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.all(paddings ?? 10),
      child: Card(
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
