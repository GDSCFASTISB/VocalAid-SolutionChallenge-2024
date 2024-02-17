import "package:gdscapp/DataModels/history.dart";
import "package:gdscapp/index.dart";
import "package:gdscapp/screens/speech_enhancement.dart";
import "package:gdscapp/vocal_aid.dart";
import "package:gdscapp/widgets/confirmation_dialog.dart";

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VocalAid system;
  late Future<List<History>> lowAccuracy;
  Vocals? randomWord;

  void logout() {
    showConfirmationDialog("Confirm Logout", "Are you sure you want to logout?")
        .then((value) {
      if (value) {
        UserPreferences.userSignedIn = false;
        UserPreferences.user = User();

        switchScreenAndRemoveAll(signInScreen);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    system = VocalAid.getSystem();
    initializeData();
  }

  void initializeData() async {
    lowAccuracy = system.getLowAccuracyWords(UserPreferences.user.userID);
    Vocals word = await system.getrandomWord();
    setState(() {
      randomWord = word;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: "Vocal Aid",
              color: colorScheme.onPrimary,
              fontSize: 26,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton.filled(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome Note",
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      menuItem("Word", wordListScreen),
                      menuItem("Histroy", "")
                    ],
                  ),
                ),
                CustomCard(
                  color: colorScheme.surface,
                  paddings: 0,
                  margins: 20,
                  child: InkWell(
                    onTap: () {
                      if (randomWord != null) {
                        switchScreenWithData(
                            SpeechEnhancement(vocal: randomWord!));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Word Of the Day",
                          color: colorScheme.onSurface,
                        ),
                        randomWord == null
                            ? const CircularProgressIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: randomWord!.words,
                                    fontSize: 40,
                                    color: colorScheme.tertiary,
                                  ),
                                  CustomText(
                                    text: randomWord!.syllables,
                                    fontSize: 20,
                                    color: colorScheme.secondary,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomCard(
                  color: colorScheme.surface,
                  paddings: 0,
                  margins: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Weekly Progress",
                        color: colorScheme.onSurface,
                      ),
                      const BarChartSample3(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const CustomText(text: "Dont Give Up, Try Again"),
                    FutureBuilder<List<History>>(
                      future: lowAccuracy,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While the Future is still loading
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          // If there's an error with the Future
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          // If the Future completed successfully, but the data is empty
                          return const Text('No data available.');
                        } else {
                          // If the Future completed successfully and has data
                          List<History> historyList = snapshot.data!;

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: historyList.map((history) {
                                return CustomCard(
                                  margins: 0,
                                  width: 200,
                                  child: InkWell(
                                    onTap: () async {
                                      switchScreenWithData(SpeechEnhancement(
                                          vocal: await system
                                              .getVocalDetails(history.word)));
                                    },
                                    child: Column(
                                      children: [
                                        CustomText(
                                          text: history.word,
                                          color: colorScheme.tertiary,
                                          fontSize: 30,
                                        ),
                                        AnimatedCircularProgressWidget(
                                          accuracy: history.accuracy,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
                Column(
                  children: [],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavBar(),
    );
  }
}

Widget menuItem(String label, String screen) {
  return TextButton(
    onPressed: () {
      switchScreen(screen);
    },
    child: CustomCard(
      width: 200,
      height: 200,
      child: CustomText(text: label),
    ),
  );
}
