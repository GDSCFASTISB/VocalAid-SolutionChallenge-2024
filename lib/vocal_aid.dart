import 'package:gdscapp/DataModels/history.dart';
import 'package:gdscapp/index.dart';

class VocalAid {
  static VocalAid? dbHandler;

  History history = History();
  Vocals vocals = Vocals();

  // Private constructor
  VocalAid._();

  // Static method to get an instance of DBHandler
  static VocalAid getSystem() {
    dbHandler ??= VocalAid._();
    return dbHandler!;
  }

  Future<Vocals> getVocalDetails(String word) {
    return vocals.getVocalDetails(word);
  }

  Future<List<History>> getLowAccuracyWords(String userID) async {
    List<History> results = await history.getLowAccuracyWords(userID);

    return results;
  }

  Future<Vocals> getrandomWord() {
    return vocals.getRandomWord();
  }
}
