import "package:gdscapp/DataModels/vocals.dart";
import "package:gdscapp/index.dart";
import "package:gdscapp/screens/speech_enhancement.dart";

class WordList extends StatefulWidget {
  const WordList({Key? key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Speech Enhancement'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Vocals>>(
                  future: db.getAllVocals(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<Vocals>> snap) {
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
                        Vocals vocals = snap.data?[index] ?? Vocals();
                        return CustomCard(
                          margins: 2,
                          paddings: 2,
                          child: ListTile(
                            title: Text(
                              vocals.words,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  vocals.syllables,
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                const Spacer(),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              switchScreenWithData(
                                  SpeechEnhancement(vocal: vocals));
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
