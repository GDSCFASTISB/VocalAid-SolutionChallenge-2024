import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimeStampSerializer implements JsonConverter<DateTime?, Timestamp?> {
  const TimeStampSerializer();

  @override
  DateTime? fromJson(Timestamp? json) => json != null ? json.toDate() : null;

  @override
  Timestamp? toJson(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime.toLocal()) : null;
  }
}
