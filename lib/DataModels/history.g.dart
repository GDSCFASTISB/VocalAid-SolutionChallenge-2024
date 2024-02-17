// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      userID: json['userID'] as String? ?? '',
      word: json['word'] as String? ?? '',
      accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0,
      points: (json['points'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'userID': instance.userID,
      'word': instance.word,
      'accuracy': instance.accuracy,
      'points': instance.points,
    };
