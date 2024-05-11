import 'package:json_annotation/json_annotation.dart';
part 'choice_response.g.dart';

@JsonSerializable()
class ChoiceResponse {
  @JsonKey(name: 'choice_id')
  int id;
  String letter;
  String? content;

  ChoiceResponse(this.id, this.letter, this.content);
  factory ChoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ChoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceResponseToJson(this);
}
