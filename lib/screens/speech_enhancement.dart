import "dart:async";
import "dart:convert";

import "package:audioplayers/audioplayers.dart";
import "package:gdscapp/index.dart";
import "package:record/record.dart";

class SpeechEnhancement extends StatefulWidget {
  const SpeechEnhancement({Key? key}) : super(key: key);

  @override
  _SpeechEnhancementState createState() => _SpeechEnhancementState();
}

class _SpeechEnhancementState extends State<SpeechEnhancement> {
  late AudioRecorder _recorder;
  late AudioPlayer _player;
  bool _recording = false;
  bool _recorderReady = false;
  String audioPath = "";

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    _player = AudioPlayer();
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

  Future<void> _playRecording() async {
    if (audioPath == "") {
      return;
    }

    try {
      Source url = UrlSource(audioPath);
      await _player.play(url);
    } catch (e) {
      debugPrint("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Speech Enhancement'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomCard(
              child: Column(
                children: [
                  Text(
                    'Honorific',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'o·nuh·ri·fuhk',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _recording = !_recording;
                });

                if (_recording) {
                  await _record();
                } else {
                  await _stopRecording();
                }

                print('Recording: $_recording');
              },
              child: Icon(_recording ? Icons.stop : Icons.mic),
            ),
            if (!_recording)
              ElevatedButton(
                onPressed: () async {
                  _playRecording();
                },
                child: Icon(Icons.refresh),
              ),
          ],
        ),
      ),
    );
  }
}
