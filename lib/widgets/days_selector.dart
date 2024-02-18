import 'package:gdscapp/index.dart';

class DaysSelector extends StatefulWidget {
  final double height;
  final String text;
  final double width;
  DaysSelector(
      {Key? key, required this.height, required this.text, required this.width})
      : super(key: key);

  @override
  _DaysSelectorState createState() => _DaysSelectorState();
}

class _DaysSelectorState extends State<DaysSelector> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.height * 0.5),
        ),
        shadowColor: Colors.black,
        child: Container(
          width: widget.width,
          height: widget.height,
          //padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.height * 0.5),
            border: Border.all(
                color: selected ? Color(0xFF008A70) : Colors.black, width: 2),
          ),
          child: Center(
            child: CustomText(
                text: widget.text, fontSize: 11, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
