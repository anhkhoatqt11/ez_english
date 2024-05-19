import 'package:json_annotation/json_annotation.dart';
part 'part_response.g.dart';


@JsonSerializable()
class PartResponse {
  int id;
  int partIndex;
  String skill;

  PartResponse(this.id, this.partIndex, this.skill);

  factory PartResponse.fromJson(Map<String, dynamic> json) => _$PartResponseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PartResponseToJson(this);


}