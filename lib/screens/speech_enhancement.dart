import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:gdscapp/widgets/waveform.dart';

import '../index.dart';

import 'dart:math' as math;

import 'dart:math';
import 'dart:convert';
import 'package:flutter_sound/flutter_sound.dart';

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
  List<double> samples = [];

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
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Speech Enhancement',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CustomCard(
              child: Column(
                children: [
                  Text(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _recording = !_recording;
                      _recordingDone = false;
                    });
                    List<double> newSamples = [];
                    if (_recording) {
                      await _record();
                    } else {
                      await _stopRecording().then((value) async {
                        newSamples =
                            await readWavFileSamplesNormalized(audioPath);
                      });
                      _recordingDone = true;

                      setState(() {
                        samples = newSamples;
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
            WaveformDisplay(samples),
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
          ],
        ),
      ),
    );
  }
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
  print(samples.length);
  return samples;
}

// List<double> loadparseJson(String jsonBody) {
//   final data = jsonDecode(jsonBody);
//   final List<int> points = List.castFrom(data['data']);
//   List<int> filteredData = [];
//   // Change this value to number of audio samples you want.
//   // Values between 256 and 1024 are good for showing [RectangleWaveform] and [SquigglyWaveform]
//   // While the values above them are good for showing [PolygonWaveform]
//   const int samples = 256;
//   final double blockSize = points.length / samples;
//   print(points.length);
//   for (int i = 0; i < samples; i++) {
//     final double blockStart =
//         blockSize * i; // the location of the first sample in the block
//     int sum = 0;
//     for (int j = 0; j < blockSize; j++) {
//       sum = sum +
//           points[(blockStart + j)
//               .toInt()]; // find the sum of all the samples in the block
//     }
//     filteredData.add((sum / blockSize)
//         .round() // take the average of the block and add it to the filtered data
//         .toInt()); // divide the sum by the block size to get the average
//   }
//   final maxNum = filteredData.reduce((a, b) => math.max(a.abs(), b.abs()));

//   final double multiplier = math.pow(maxNum, -1).toDouble();

//   return filteredData.map<double>((e) => (e * multiplier)).toList();
// }

// Future<void> generateJsonRepresentation(
//     String inputFilePath,
//     String outputFilePath,
//     int samples,
//     int precision,
//     bool normalize,
//     bool logarithmic) async {
//   final file = File(inputFilePath);
//   final data = await file.readAsBytes();
//   final buffer =
//       (await FlutterSoundHelper().wavToPCM(inputFilePath: inputFilePath)).data!;

//   int numChannels =
//       1; // Assuming mono for simplicity; modify as needed for stereo
//   List<double> audioData = buffer.buffer.asFloat32List();

//   // Linear Interpolation (simplified version)
//   List<double> interpolatedData = linearInterpolation(audioData, samples);

//   if (logarithmic) {
//     interpolatedData = interpolatedData.map((val) => lin2log(val)).toList();
//   }

//   if (normalize) {
//     double maxVal =
//         interpolatedData.fold(0, (prev, curr) => max(prev.abs(), curr.abs()));
//     interpolatedData = interpolatedData.map((val) => val / maxVal).toList();
//   }

//   // Convert to specified precision
//   interpolatedData = interpolatedData
//       .map((val) => double.parse(val.toStringAsFixed(precision)))
//       .toList();

//   // Output JSON
//   Map<String, dynamic> jsonMap = {
//     'data': interpolatedData,
//   };
//   final jsonString = jsonEncode(jsonMap);
//   final outputFile = File(outputFilePath);
//   await outputFile.writeAsString(jsonString);
// }

// List<double> linearInterpolation(List<double> data, int samples) {
//   int dataSize = data.length;
//   List<double> result = List.filled(samples, 0);
//   for (int i = 0; i < samples; i++) {
//     double idx = (i * (dataSize - 1)) / (samples - 1);
//     int idxInt = idx.toInt();
//     double frac = idx - idxInt;
//     double interpValue = data[idxInt] +
//         (frac * (data[min(idxInt + 1, dataSize - 1)] - data[idxInt]));
//     result[i] = interpValue;
//   }
//   return result;
// }

// double lin2log(double val) {
//   const double referenceValue = 1.0;
//   double dbValue = 20 * log(val / referenceValue) / ln10;
//   // Clip to range -60dB to 0dB for simplicity, adjust as needed
//   dbValue = max(-60, min(0, dbValue));
//   // Map to range -1.0 to 1.0, adjust formula as needed
//   return dbValue / 60;
// }

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
