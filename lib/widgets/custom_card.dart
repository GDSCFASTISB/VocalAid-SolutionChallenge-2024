import 'package:gdscapp/index.dart';

class CustomCard extends Card {
  final Widget child;
  final Color? color;

  const CustomCard({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(10),
      child: Card(
          color: color ?? const Color.fromARGB(255, 147, 195, 207),
          child: Container(margin: const EdgeInsets.all(10), child: child)),
    );
  }
}
