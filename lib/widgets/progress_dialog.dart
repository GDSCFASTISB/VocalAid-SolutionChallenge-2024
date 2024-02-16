export 'package:sn_progress_dialog/progress_dialog.dart';

import '../index.dart';

class CustomProgressDialog {
  static final ProgressDialog _progressDialog =
      ProgressDialog(context: appNavigationKey.currentContext);
  static showProDialog(String msg) async {
    if (!_progressDialog.isOpen()) {
      _progressDialog.show(max: 100, msg: '$msg...', msgMaxLines: 5);
    }
  }

  static hideProDialog() async {
    _progressDialog.close();
  }
}
