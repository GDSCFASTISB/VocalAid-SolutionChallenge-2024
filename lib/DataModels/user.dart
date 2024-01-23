import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String name;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);

  User({this.name = ''});
}
