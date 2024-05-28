import 'package:ez_english/data/response/answer_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_response.g.dart';
@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: "question_id")
  int id;
  List<String> questions;
  List<AnswerResponse> answers;
  @JsonKey(name: "imageurl")
  String? imageUrl;
  @JsonKey(name: "audiourl")
  String? audioUrl;
  @JsonKey(name: "test_id")
  int? testId;
  @JsonKey(name: "part_id")
  int partId;


  QuestionResponse(this.id, this.questions, this.answers, this.imageUrl,
      this.audioUrl, this.testId, this.partId);

  factory QuestionResponse.fromJson(Map<String, dynamic> json) => _$QuestionResponseFromJson(json);


  Map<String, dynamic> toJson() => _$QuestionResponseToJson(this);
}
