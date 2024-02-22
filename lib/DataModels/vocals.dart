import 'package:json_annotation/json_annotation.dart';

import '../index.dart';

part 'vocals.g.dart';

@JsonSerializable()
class Vocals {
  String words;
  String syllables;
  String audioWaveUrl;

  factory Vocals.fromJson(Map<String, dynamic> json) => _$VocalsFromJson(json);
  toJson() => _$VocalsToJson(this);

  Vocals({this.words = '', this.syllables = '', this.audioWaveUrl = ''});

  Future<Vocals> getVocalDetails(String word) {
    DBHandler db = DBHandler.getDBHandler();

    return db.getVocalDetail(word);
  }

  Future<Vocals> getRandomWord() async {
    DBHandler db = DBHandler.getDBHandler();

    List<Vocals> vocals = await db.getAllVocals();
    int randomSeed = DateTime.now().day; // Use the current day as the seed
    Random random = Random(randomSeed);

    // Generate a random integer between 0 (inclusive) and 100 (exclusive)
    int randomInt = random.nextInt(vocals.length);
    return vocals[randomInt];
  }
}
