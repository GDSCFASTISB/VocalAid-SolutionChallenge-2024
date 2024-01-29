// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? '',
      emailAddress: json['emailAddress'] as String? ?? '',
      phNO: json['phNO'] as String? ?? '',
      password: json['password'] as String? ?? '',
      gender: json['gender'] as bool?,
      dob: const TimeStampSerializer().fromJson(json['dob'] as Timestamp?),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'emailAddress': instance.emailAddress,
      'phNO': instance.phNO,
      'password': instance.password,
      'gender': instance.gender,
      'dob': const TimeStampSerializer().toJson(instance.dob),
    };
