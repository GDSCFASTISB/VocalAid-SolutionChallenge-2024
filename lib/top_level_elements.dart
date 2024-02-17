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
const historyListScreen = "/historyList";
const homePageScreen = "/homePage";

// Firebase
var fBAuth = FirebaseAuth.instance;
var storage = FirebaseStorage.instance.ref();

//Color Scheme
var colorScheme = Theme.of(appNavigationKey.currentContext!).colorScheme;

//Storages
final orginalRecordingsStorage = storage.child("orginalRecordings");

///   KEYS FOR PREFERENCES
const keyUser = "user";
const keySignedIn = "signedIn";
const keyRememberMe = "rememberMe";
const String keyUsername = 'username';
const String keyPassword = 'password';
