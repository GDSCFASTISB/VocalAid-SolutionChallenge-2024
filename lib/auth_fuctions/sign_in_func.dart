import 'package:firebase_auth/firebase_auth.dart' as auth;
import "package:gdscapp/index.dart";
import 'package:gdscapp/screens/Profile.dart';

Future<void> signIn(String email, String pass) async {
  DBHandler db = DBHandler.getDBHandler();
  CustomProgressDialog.showProDialog("Signing in");
  try {
    await fBAuth
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((value) async {
      User? user = await db.getUser(email);
      CustomProgressDialog.hideProDialog();

      if (user != null) {
        print("signed in");
        UserPreferences.user = user;
        UserPreferences.userSignedIn = true;

        switchScreenAndRemoveAll(homePageScreen);
      } else {
        showToast("user credentials not found");
      }
    });
  } on auth.FirebaseAuthException catch (e) {
    print(e);
    showToast("user credentials not found");
    CustomProgressDialog.hideProDialog();
    if (e.code == 'user-not-found') {
      showToast('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      showToast('Wrong password provided for that user.');
    }
  }
}
