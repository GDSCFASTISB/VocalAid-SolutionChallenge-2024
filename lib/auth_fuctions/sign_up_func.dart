import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../index.dart';

//sinup function:
Future<void> signUp(User user) async {
  DBHandler db = DBHandler.getDBHandler();
  try {
    auth.UserCredential userSignupCredential =
        await fBAuth.createUserWithEmailAndPassword(
      email: user.emailAddress,
      password: user.password,
    );

    user.userID = userSignupCredential.user?.uid ?? '';
    db.addUser(user);
    CustomProgressDialog.hideProDialog();
    showToast("Signed up successfully");
    switchScreenAndRemoveAll(signInScreen);
  } on auth.FirebaseAuthException catch (e) {
    CustomProgressDialog.hideProDialog();
    if (e.code == 'weak-password') {
      showToast('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      showToast('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
