import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdscapp/index.dart';

final GlobalKey<NavigatorState> appNavigationKey = GlobalKey<NavigatorState>();

showToast(String msg) {
  ScaffoldMessenger.of(appNavigationKey.currentContext!).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}

switchScreenAndRemoveAll(String screenName) {
  Navigator.of(appNavigationKey.currentContext!)
      .pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false);
}

switchScreen(String screenName) {
  Navigator.of(appNavigationKey.currentContext!).pushNamed(
    screenName,
  );
}

switchScreenWithData(Widget screen) {
  Navigator.push(
    appNavigationKey.currentContext!,
    MaterialPageRoute(builder: (context) => screen),
  );
}

//routes
const signInScreen = "/signIn";
const signUpScreen = "/signUp";
const speechEnhancementScreen = "/speechEnhancementScreen";
const wordListScreen = "/wordList";

var fBAuth = FirebaseAuth.instance;
var storage = FirebaseStorage.instance.ref();
final orginalRecordingsStorage = storage.child("orginalRecordings");
