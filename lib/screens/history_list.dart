import "package:gdscapp/DataModels/vocals.dart";
import "package:gdscapp/index.dart";
import "package:gdscapp/screens/speech_enhancement.dart";

import "../DataModels/history.dart";

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DBHandler db = DBHandler.getDBHandler();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Words',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<History>>(
                  future: db.getHistory(UserPreferences.user.userID),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<History>> snap) {
                    if (snap.hasError) {
                      return const Center(
                        child: Text("Error Loading data"),
                      );
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("loading data -> "),
                      );
                    }

                    if (snap.data == null) {
                      return const Center(
                        child: Text("Error Loading data"),
                      );
                    }
                    return ListView.builder(
                      itemCount: snap.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        History vocals = snap.data?[index] ?? History();
                        return CustomCard(
                          margins: 2,
                          paddings: 2,
                          child: ListTile(
                            title: Text(
                              vocals.word,
                              style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // vocals.syllables,
                                  "",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: colorScheme.onSurface),
                                ),
                                const Spacer(),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // switchScreenWithData(
                              //     SpeechEnhancement(vocal: vocals));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
