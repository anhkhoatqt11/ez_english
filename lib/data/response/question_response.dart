import 'package:json_annotation/json_annotation.dart';

import 'choice_response.dart';
part 'question_response.g.dart';
@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: "question_id")
  int id;
  String? title;
  @JsonKey(name: "correct_letter")
  String? correctLetter;
  @JsonKey(name: "imageurl")
  String? imageUrl;
  @JsonKey(name: "audiourl")
  String? audioUrl;
  @JsonKey(name: "test_id")
  int? testId;
  String? explanation;
  @JsonKey(name: "part_id")
  int partId;
  @JsonKey(name: "choice")
  List<ChoiceResponse> choices;


  QuestionResponse(this.id, this.title, this.correctLetter, this.imageUrl,
      this.audioUrl, this.testId, this.explanation, this.partId, this.choices);

  factory QuestionResponse.fromJson(Map<String, dynamic> json) => _$QuestionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}
