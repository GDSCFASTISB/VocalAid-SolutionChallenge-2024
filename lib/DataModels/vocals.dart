import 'package:json_annotation/json_annotation.dart';

part 'vocals.g.dart';

@JsonSerializable()
class Vocals {
  String words;
  String syllables;
  String audioWaveUrl;

  factory Vocals.fromJson(Map<String, dynamic> json) => _$VocalsFromJson(json);
  toJson() => _$VocalsToJson(this);

  Vocals({this.words = '', this.syllables = '', this.audioWaveUrl = ''});
}
