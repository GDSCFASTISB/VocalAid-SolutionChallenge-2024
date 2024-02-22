import 'dart:typed_data';

import 'package:gdscapp/screens/home_page.dart';

import '../index.dart';

import 'dart:math' as math;

import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';
import 'package:just_waveform/just_waveform.dart';

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
  double accuracy = 65;
  bool improvement = false;
  String modelOutput = "";
  final progressStream = BehaviorSubject<WaveformProgress>();
  final progressStreamOriginal = BehaviorSubject<WaveformProgress>();

  List<double> samples = [];
  List<double> originalSamples = [];

  late String originalRecordingPath;
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
    modelOutput = widget.vocal.words;
    // _player = AudioPlayer();
    _init();

    _initRecorder();
  }

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      Reference islandRef;
      islandRef = orginalRecordingsStorage.child(widget.vocal.audioWaveUrl);
      final appDocDir = await getTemporaryDirectory();
      final filePath =
          "${appDocDir.absolute.path}/${widget.vocal.audioWaveUrl}";
      debugPrint(filePath);
      final audioFile = File(filePath);

      try {
        await islandRef.writeToFile(audioFile);
      } on FirebaseException catch (e) {
        // Handle Firebase Storage exception here.
        print("Firebase Storage Error: $e");
      } catch (e) {
        // Handle other exceptions.
        print("Error: $e");
        //Navigator.pop(context);
      }
      final waveFile =
          File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
      try {
        JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
            .listen(progressStream.add, onError: (error) {
          print("Error during waveform extraction: $error");
          progressStream.addError(error);
        });
      } catch (e) {
        print("Exception caught during waveform extraction setup: $e");
      }
    } catch (e) {
      progressStream.addError(e);
    }
  }

  String replaceDotWithDash(String input) {
    return input.replaceAll('.', '-');
  }

  void updateAccuracy(double accuracyNew) {
    accuracy = accuracyNew;
  }

  Future<void> _initOriginalRecording() async {
    try {
      final waveFile = File(p.join(
          (await getTemporaryDirectory()).path, 'waveformOriginal.wave'));
      try {
        JustWaveform.extract(
                audioInFile: File(audioPath), waveOutFile: waveFile)
            .listen(progressStreamOriginal.add, onError: (error) {
          print("Error during waveform extraction: $error");
          progressStreamOriginal.addError(error);
        });
      } catch (e) {
        print("Exception caught during waveform extraction setup: $e");
      }
    } catch (e) {
      progressStreamOriginal.addError(e);
    }
  }

  // Future<void> fetchOriginalRecording() async {
  //   try {
  //     Reference islandRef;
  //     islandRef = orginalRecordingsStorage.child(widget.vocal.audioWaveUrl);
  //     final appDocDir = await getTemporaryDirectory();
  //     final filePath =
  //         "${appDocDir.absolute.path}/${widget.vocal.audioWaveUrl}";
  //     debugPrint(filePath);
  //     final file = File(filePath);

  //     try {
  //       await islandRef.writeToFile(file);
  //     } on FirebaseException catch (e) {
  //       // Handle Firebase Storage exception here.
  //       print("Firebase Storage Error: $e");
  //     } catch (e) {
  //       // Handle other exceptions.
  //       print("Error: $e");
  //       //Navigator.pop(context);
  //     }

  //     setState(() {
  //       originalRecordingPath = filePath;
  //     });
  //   } catch (e) {
  //     print("Error during download: $e");
  //     // Navigator.pop(context);
  //   }
  // }

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

  double points = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Speech Enhancement',
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 50),
        child: Center(
          child: Column(
            children: [
              CustomCard(
                child: Column(
                  children: [
                    _recordingDone
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: spans,
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface),
                                ),
                              ),
                            ],
                          )
                        : Text(
                            widget.vocal.words,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface),
                          ),
                    Text(
                      widget.vocal.syllables,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: improvement,
                child: Column(
                  children: [
                    CustomCard(
                        child: Center(
                      child: CustomText(
                        text: replaceDotWithDash(widget.vocal.syllables),
                        fontSize: 30,
                      ),
                    )),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            width: double.maxFinite,
                            child: StreamBuilder<WaveformProgress>(
                              stream: progressStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                final progress = snapshot.data?.progress ?? 0.0;
                                final waveform = snapshot.data?.waveform;
                                if (waveform == null) {
                                  return Center(
                                    child: Text(
                                      '${(100 * progress).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  );
                                }
                                return AudioWaveformWidget(
                                  waveform: waveform,
                                  start: Duration.zero,
                                  duration: waveform.duration,
                                );
                              },
                            ),
                          ),
                          CustomText(text: "Original Prononciation")
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            width: double.maxFinite,
                            child: StreamBuilder<WaveformProgress>(
                              stream: progressStreamOriginal,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      'Error: ${snapshot.error}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                final progress = snapshot.data?.progress ?? 0.0;
                                final waveform = snapshot.data?.waveform;
                                if (waveform == null) {
                                  return Center(
                                    child: Text(
                                      '${(100 * progress).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  );
                                }
                                return AudioWaveformWidget(
                                  waveform: waveform,
                                  start: Duration.zero,
                                  duration: waveform.duration,
                                );
                              },
                            ),
                          ),
                          CustomText(text: "Your Prononciation")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
                        spans = [];
                        await _record();
                      } else {
                        await _stopRecording().then((value) async {
                          await _initOriginalRecording();
                        });
                        _recordingDone = true;
                        buildSpan();
                        setState(() {
                          // samples = newSamples;
                          // originalSamples = initOrigSamples;
                          accuracy = calculateAccuracy() * 100;
                          points = calculateAccuracy() * 10;
                        });
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
              Visibility(
                visible: _recordingDone,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedCircularProgressWidget(accuracy: accuracy),
                          Column(
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText(
                                    '$points',
                                    textStyle: GoogleFonts.lato(
                                      fontSize: 65,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
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
              Visibility(
                visible: accuracy <= 70 && _recordingDone,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const CustomText(
                          text: "Do you want to improve this word?",
                          fontSize: 18,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _recordingDone = false;
                                    improvement = true;
                                  });
                                },
                                child: const Text("Yes")),
                            ElevatedButton(
                                onPressed: () {
                                  switchScreenAndRemoveAll(homePageScreen);
                                },
                                child: const Text("No")),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Visibility(
              //   visible: _recordingDone,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       CustomCard(
              //         margins: 20,
              //         paddings: 0,
              //         child: Column(
              //           children: [
              //             WaveformDisplay(samples),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             CustomText(
              //               text: "Your Prononciation",
              //               color: colorScheme.onBackground,
              //             )
              //           ],
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       CustomCard(
              //         margins: 20,
              //         paddings: 0,
              //         child: Column(
              //           children: [
              //             WaveformDisplay(originalSamples),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             CustomText(
              //               text: "Original Prononciation",
              //               color: colorScheme.onBackground,
              //             )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> spans = [];

  void buildSpan() {
    int gtPointer = 0;
    int correctCount = 0;
    for (int i = 0; i < modelOutput.length; i++) {
      final moChar = modelOutput[i];
      if (gtPointer < groundTruth.length && moChar == groundTruth[gtPointer]) {
        spans
            .add(TextSpan(text: moChar, style: TextStyle(color: Colors.green)));
        correctCount++;
        gtPointer++;
      } else {
        if (gtPointer < groundTruth.length) {
          spans
              .add(TextSpan(text: moChar, style: TextStyle(color: Colors.red)));
          spans.add(TextSpan(
              // text: " [Expected: ${groundTruth[gtPointer]}]",
              style: TextStyle(color: Colors.blue)));
          gtPointer++;
        } else {
          spans
              .add(TextSpan(text: moChar, style: TextStyle(color: Colors.red)));
        }
      }
    }
  }

  double calculateAccuracy() {
    int correctCount = 0;
    int gtPointer = 0;

    for (int i = 0; i < modelOutput.length; i++) {
      if (gtPointer < groundTruth.length &&
          modelOutput[i] == groundTruth[gtPointer]) {
        correctCount++;
      }
      if (gtPointer < groundTruth.length) {
        gtPointer++;
      }
    }

    return correctCount / groundTruth.length;
  }

  String groundTruth = "friensdvns";
}

/// Reads a WAV file, assuming it's encoded in a standard PCM format, and normalizes its audio samples.
/// This function is compatible with WAV files produced using standard encoding settings, including `AudioEncoder.wav`.
///
/// @param filePath The path to the WAV file.
/// @return A future that resolves to a list of normalized audio samples.

Future<List<double>> readWavFileSamplesNormalized(String filePath) async {
  var file = File(filePath);
  var fileBytes = await file.readAsBytes();

  var buffer = fileBytes.buffer;

  // Assuming a 44-byte header for a simple PCM WAV file
  int headerSize = 44;
  // WAV files are little endian
  var byteData = buffer.asByteData();

  // Extracting format details
  int numChannels = 1;
  int bitsPerSample = 16; // Bits per sample

  // if (audioFormat != 1) {
  //   // PCM Check to ensure compatibility with AudioEncoder.wav
  //   throw Exception(
  //       "Unsupported WAV file format. Only PCM is supported, compatible with `AudioEncoder.wav`.");
  // }

  // Calculate number of samples
  int bytesPerSample = bitsPerSample ~/ 8;
  int numSamples =
      (fileBytes.length - headerSize) ~/ (bytesPerSample * numChannels);

  List<double> samples = [];
  for (int i = 0; i < numSamples * numChannels; i++) {
    if (bitsPerSample == 16) {
      int sampleIndex = headerSize + i * bytesPerSample;
      int sampleValue = byteData.getInt16(sampleIndex, Endian.little);
      // Normalize the sample to the range [-1.0, 1.0]
      double normalizedSample =
          sampleValue / 32768.0; // 32768 is the max value for 16-bit audio
      samples.add(normalizedSample);
    } else {
      // Additional handling for other bits per sample if necessary
    }
  }

  double max = 0;
  print(samples.length);
  for (int i = 0; i < 3000; i++) {
    if (samples[i] > max) max = samples[i];
    // print(samples[i]);
    samples[i] = 0.0;
  }
  List<double> newSamples =
      samples.skipWhile((value) => value < 0.006).toList();
  print(max);
  return newSamples;
}

class AudioWaveformWidget extends StatefulWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  const AudioWaveformWidget({
    Key? key,
    required this.waveform,
    required this.start,
    required this.duration,
    this.waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : super(key: key);

  @override
  _AudioWaveformState createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveformWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          waveColor: widget.waveColor,
          waveform: widget.waveform,
          start: widget.start,
          duration: widget.duration,
          scale: widget.scale,
          strokeWidth: widget.strokeWidth,
          pixelsPerStep: widget.pixelsPerStep,
        ),
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    Color waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final sampleStart = -sampleOffset % waveformPixelsPerStep;
    for (var i = sampleStart.toDouble();
        i <= waveformPixelsPerWindow + 1.0;
        i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return false;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();
      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();
      return height - 1 - y * height / 256;
    }
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
