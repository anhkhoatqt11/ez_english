import 'package:json_annotation/json_annotation.dart';
part 'answer_response.g.dart';



@JsonSerializable()
class AnswerResponse {
  List<String> answers;
  String? explanation;
  @JsonKey(name: "correct_answer")
  int correctAnswer;

  AnswerResponse(this.answers, this.explanation, this.correctAnswer);


  factory AnswerResponse.fromJson(Map<String, dynamic> json) => _$AnswerResponseFromJson(json);


  Map<String, dynamic> toJson() => _$AnswerResponseToJson(this);
}