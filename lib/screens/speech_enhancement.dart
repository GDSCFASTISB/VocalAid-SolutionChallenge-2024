import '../index.dart';

class SpeechEnhancement extends StatefulWidget {
  final Vocals vocal;
  const SpeechEnhancement({
    super.key,
    required this.vocal,
  });

  @override
  _SpeechEnhancementState createState() => _SpeechEnhancementState();
}

class _SpeechEnhancementState extends State<SpeechEnhancement> {
  late AudioRecorder _recorder;
  // late AudioPlayer _player;
  bool _recording = false;
  bool _recorderReady = false;
  String audioPath = "";
  bool _recordingDone = false;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    // _player = AudioPlayer();
    _initRecorder();
  }

  @override
  void dispose() {
    _recorder.dispose();

    super.dispose();
  }

  Future<void> _initRecorder() async {
    final status = await Permission.microphone.request();

    if (status == PermissionStatus.granted) {
      // await _recorder.openRecorder();
      // print("Hello");
      // print(_recorder.dispositionStream());
      // recorderStream = _recorder.dispositionStream()!.listen((event) {
      //   print(event.decibels ?? 0.0);
      // });
      _recorderReady = true;
    } else {
      throw 'Microphone permission not granted';
    }
  }

  Future<void> _record() async {
    if (!_recorderReady) {
      return;
    }

    Directory tempDir = await getTemporaryDirectory();
    File outputFile = File('${tempDir.path}/flutter_sound_tmp.wav');

    try {
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav),
        path: outputFile.path,
      );
      print("ypo");
    } catch (e) {
      // Handle recorder start error
      print('Recorder start error: $e');
    }
  }

  Future<void> _stopRecording() async {
    if (!_recorderReady) {
      return;
    }

    try {
      final path = await _recorder.stop();
      final audioFile = File(path!);
      setState(() {
        audioPath = path;
      });
      print('Audio file path: $path');
    } catch (e) {
      // Handle recorder stop error
      print('Recorder stop error: $e');
    }
  }

  // Future<void> _playRecording() async {
  //   if (audioPath == "") {
  //     return;
  //   }

  //   try {
  //     Source url = UrlSource(audioPath);
  //     await _player.play(url);
  //   } catch (e) {
  //     debugPrint("$e");
  //   }
  // }

  int points = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Speech Enhancement'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomCard(
              child: Column(
                children: [
                  Text(
                    widget.vocal.words,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.vocal.syllables,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _recording = !_recording;
                      _recordingDone = false;
                    });

                    if (_recording) {
                      await _record();
                    } else {
                      await _stopRecording();
                      _recordingDone = true;
                    }

                    print('Recording: $_recording');
                  },
                  child: Icon(_recording ? Icons.stop : Icons.mic),
                ),
                if (!_recording)
                  ElevatedButton(
                    onPressed: () async {},
                    child: const Icon(Icons.refresh),
                  ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: _recordingDone,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const AnimatedCircularProgressWidget(
                          accuracy: 70,
                        ),
                        Column(
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText(
                                  '$points',
                                  textStyle: GoogleFonts.lato(
                                    fontSize: 65,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                              isRepeatingAnimation: false,
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                            const CustomText(text: "You scored"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// final csvFile =
//                       File('/Users/ryan/Developer/gdscapp/assets/data.csv')
//                           .readAsStringSync();
//                   final csvToList = const CsvToListConverter().convert(csvFile);
//                   DBHandler dbHandler = DBHandler.getDBHandler();
//                   CustomProgressDialog.showProDialog("uploading files");
//                   for (final row in csvToList) {
//                     try {
//                       File file = File(
//                           '/Users/ryan/Developer/gdscapp/assets/${row[8]}.wav');
//                       await orginalRecordingsStorage
//                           .child("${row[8]}")
//                           .putData(file.readAsBytesSync());

//                       await dbHandler.db.collection("vocals").doc().set(Vocals(
//                               words: row[0],
//                               syllables: row[6],
//                               audioWaveUrl: row[8])
//                           .toJson());
//                     } catch (e) {
//                       print('error while uploading file $e');
//                     }

//                     print(row[0]);
//                     print(row[6]);
//                     print('/Users/ryan/Developer/gdscapp/assets/${row[8]}.csv');
//                   }
//                   CustomProgressDialog.hideProDialog();