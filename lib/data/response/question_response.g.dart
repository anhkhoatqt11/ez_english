// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResponse _$QuestionResponseFromJson(Map<String, dynamic> json) =>
    QuestionResponse(
      (json['question_id'] as num).toInt(),
      json['title'] as String?,
      json['correct_letter'] as String?,
      json['imageurl'] as String?,
      json['audiourl'] as String?,
      (json['test_id'] as num?)?.toInt(),
      json['explanation'] as String?,
      (json['part_id'] as num).toInt(),
      (json['choice'] as List<dynamic>)
          .map((e) => ChoiceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionResponseToJson(QuestionResponse instance) =>
    <String, dynamic>{
      'question_id': instance.id,
      'title': instance.title,
      'correct_letter': instance.correctLetter,
      'imageurl': instance.imageUrl,
      'audiourl': instance.audioUrl,
      'test_id': instance.testId,
      'explanation': instance.explanation,
      'part_id': instance.partId,
      'choice': instance.choices,
    };
