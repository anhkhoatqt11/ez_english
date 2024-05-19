// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartResponse _$PartResponseFromJson(Map<String, dynamic> json) => PartResponse(
      (json['id'] as num).toInt(),
      (json['partIndex'] as num).toInt(),
      json['skill'] as String,
    );

Map<String, dynamic> _$PartResponseToJson(PartResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partIndex': instance.partIndex,
      'skill': instance.skill,
    };
