// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      json['uuid'] as String,
      DateTime.parse(json['updated_at'] as String),
      json['full_name'] as String,
      json['avatar_url'] as String,
      LevelResponse.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'updated_at': instance.updateAt.toIso8601String(),
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'level': instance.levelResponse,
    };

LevelResponse _$LevelResponseFromJson(Map<String, dynamic> json) =>
    LevelResponse(
      json['level_name'] as String,
      (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$LevelResponseToJson(LevelResponse instance) =>
    <String, dynamic>{
      'level_name': instance.levelName,
      'value': instance.value,
    };
