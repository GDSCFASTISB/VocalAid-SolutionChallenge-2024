// import 'package:gdscapp/DataModels/vocals.dart';
// import 'package:gdscapp/index.dart';

import 'package:gdscapp/db_handler.dart';
import 'package:gdscapp/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class History {
  String userID;
  String word;
  double accuracy;
  double points;

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);
  toJson() => _$HistoryToJson(this);

  History({
    this.userID = '',
    this.word = '',
    this.accuracy = 0,
    this.points = 0,
  });

  Future<List<History>> getHistory(String userID) {
    DBHandler db = DBHandler.getDBHandler();

    return db.getHistory(userID);
  }

  void setHistory(History history) {
    DBHandler db = DBHandler.getDBHandler();

    db.setHistory(history);
  }

  Future<List<History>> getLowAccuracyWords(String userID) async {
    List<History> allWords = await getHistory(userID);

    List<History> lowAccuracyWords =
        allWords.where((word) => word.accuracy < 50).toList();

    return lowAccuracyWords;
  }
}
