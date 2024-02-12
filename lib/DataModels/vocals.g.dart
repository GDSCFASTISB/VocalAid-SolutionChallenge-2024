// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vocals _$VocalsFromJson(Map<String, dynamic> json) => Vocals(
      words: json['words'] as String? ?? '',
      syllables: json['syllables'] as String? ?? '',
      audioWaveUrl: json['audioWaveUrl'] ?? '',
    );

Map<String, dynamic> _$VocalsToJson(Vocals instance) => <String, dynamic>{
      'words': instance.words,
      'syllables': instance.syllables,
      'audioWaveUrl': instance.audioWaveUrl,
    };
