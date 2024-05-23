// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerResponse _$AnswerResponseFromJson(Map<String, dynamic> json) =>
    AnswerResponse(
      (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      json['explanation'] as String?,
      (json['correct_answer'] as num).toInt(),
    );

Map<String, dynamic> _$AnswerResponseToJson(AnswerResponse instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'explanation': instance.explanation,
      'correct_answer': instance.correctAnswer,
    };
