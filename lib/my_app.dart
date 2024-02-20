import 'package:gdscapp/index.dart';
import 'package:gdscapp/screens/challenge_screen.dart';
import 'package:gdscapp/screens/history_list.dart';
import 'package:gdscapp/screens/home_page.dart';
import 'package:gdscapp/screens/sign_in.dart';
import 'package:gdscapp/screens/sign_up.dart';
import 'package:gdscapp/screens/words_list.dart';
import 'package:gdscapp/screens/profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF008A70)),
          scaffoldBackgroundColor: const Color.fromARGB(255, 250, 249, 246),
          useMaterial3: true,
        ),
        navigatorKey: appNavigationKey,
        home: UserPreferences.userSignedIn
            ? const MyHomePage()
            : const LoginPage(),
        routes: {
          signInScreen: (context) => const LoginPage(),
          signUpScreen: (context) => const SignUp(),
          wordListScreen: (context) => const WordList(),
          historyListScreen: (context) => const HistoryList(),
          homePageScreen: (context) => const MyHomePage(),
          profileScreen: (context) => const ProfilePage(),
          challengeScreen: (context) => const Challenge_screen(),
        });
  }
}
