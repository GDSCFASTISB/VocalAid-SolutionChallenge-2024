import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdscapp/DataModels/time_stamp_serializer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;
  String emailAddress;
  String phNO;
  String password;
  bool? gender;

  @TimeStampSerializer()
  DateTime? dob;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);

  User(
      {this.name = '',
      this.emailAddress = '',
      this.phNO = '',
      this.password = '',
      this.gender,
      this.dob});
}
