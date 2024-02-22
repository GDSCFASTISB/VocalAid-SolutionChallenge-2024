String? validateEmail(String? value) {
  String? _msg;
  RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (value!.isEmpty) {
    _msg = "Email is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Password is required";
  }
  return _msg;
}
