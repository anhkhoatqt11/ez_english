// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionResponse _$QuestionResponseFromJson(Map<String, dynamic> json) =>
    QuestionResponse(
      (json['question_id'] as num).toInt(),
      (json['questions'] as List<dynamic>).map((e) => e as String).toList(),
      (json['answers'] as List<dynamic>)
          .map((e) => AnswerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageurl'] as String?,
      json['audiourl'] as String?,
      (json['test_id'] as num?)?.toInt(),
      (json['part_id'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionResponseToJson(QuestionResponse instance) =>
    <String, dynamic>{
      'question_id': instance.id,
      'questions': instance.questions,
      'answers': instance.answers,
      'imageurl': instance.imageUrl,
      'audiourl': instance.audioUrl,
      'test_id': instance.testId,
      'part_id': instance.partId,
    };
