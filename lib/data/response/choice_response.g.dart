// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceResponse _$ChoiceResponseFromJson(Map<String, dynamic> json) =>
    ChoiceResponse(
      (json['choice_id'] as num).toInt(),
      json['letter'] as String,
      json['content'] as String?,
    );

Map<String, dynamic> _$ChoiceResponseToJson(ChoiceResponse instance) =>
    <String, dynamic>{
      'choice_id': instance.id,
      'letter': instance.letter,
      'content': instance.content,
    };
