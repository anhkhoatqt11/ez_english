import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  String uuid;
  @JsonKey(name: "updated_at")
  DateTime updateAt;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "avatar_url")
  String avatarUrl;
  @JsonKey(name: "level")
  LevelResponse levelResponse;

  ProfileResponse(this.uuid, this.updateAt, this.fullName, this.avatarUrl,
      this.levelResponse);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}

@JsonSerializable()
class LevelResponse {
  @JsonKey(name: "level_name")
  String levelName;
  int value;

  LevelResponse(this.levelName, this.value);

  factory LevelResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LevelResponseToJson(this);
}
