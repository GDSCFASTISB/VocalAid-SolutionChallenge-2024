import 'package:gdscapp/index.dart';

class TimeSelector extends StatefulWidget {
  final double height;
  final String text;

  TimeSelector({Key? key, required this.height, required this.text})
      : super(key: key);

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
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
          borderRadius: BorderRadius.circular(widget.height * 0.25),
        ),
        shadowColor: Colors.black,
        child: Container(
          //height: widget.height,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.height * 0.25),
            border: Border.all(
                color: selected ? Color(0xFF008A70) : Colors.black, width: 2),
          ),
          child: CustomText(
              text: widget.text, fontSize: 11, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
