import '../index.dart';

class ConfirmationDialog extends StatefulWidget {
  final String? title;
  final String? description;
  late bool? courseJoining = false;

  ConfirmationDialog({
    super.key,
    this.title,
    this.description,
    this.courseJoining,
  });

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorScheme.inverseSurface,
      title: Text(widget.title!,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline6!.fontSize,
            fontWeight: FontWeight.w500,
            color: colorScheme.onInverseSurface,
          )),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(widget.description!,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1!.fontSize,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onInverseSurface,
                )),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: CustomText(
            text: 'confirm',
            color: colorScheme.onInverseSurface,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        TextButton(
          child: Text(
            'cancel',
            style: TextStyle(
              color: colorScheme.onInverseSurface,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ],
    );
  }
}

Future<bool> showConfirmationDialog(String title, String description) async {
  BuildContext context = appNavigationKey.currentContext!;
  bool result = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: ConfirmationDialog(
            title: title,
            description: description,
          ));
    },
  );
  return result;
}

Future<bool> showConfirmationDialogForJoiningCourse(
    String title, String description, bool joining) async {
  BuildContext context = appNavigationKey.currentContext!;
  bool result = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child: ConfirmationDialog(
            title: title,
            description: description,
            courseJoining: joining,
          ));
    },
  );
  return result;
}
