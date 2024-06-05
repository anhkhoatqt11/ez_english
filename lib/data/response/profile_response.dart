class ProfileResponse {
  String uuid;
  DateTime updateAt;
  String fullName;
  String avatarUrl;
  LevelResponse levelResponse;

  ProfileResponse(this.uuid, this.updateAt, this.fullName, this.avatarUrl,
      this.levelResponse);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      json['uuid'] as String,
      DateTime.parse(json['updated_at'] as String),
      json['full_name'] as String,
      json['avatar_url'] as String,
      LevelResponse.fromJson(json['level']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'updated_at': updateAt.toIso8601String(),
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'level': levelResponse.toJson(),
    };
  }
}

class LevelResponse {
  int levelId;
  String levelName;
  int value;

  LevelResponse(this.levelId, this.levelName, this.value);

  factory LevelResponse.fromJson(Map<String, dynamic> json) {
    return LevelResponse(
      (json['level_id'] as num).toInt(),
      json['level_name'] as String,
      (json['value'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'level_id': levelId,
      'level_name': levelName,
      'value': value,
    };
  }
}
