import 'package:ez_english/data/response/answer_response.dart';

class QuestionResponse {
  int id;
  List<String> questions;
  List<AnswerResponse> answers;
  String? imageUrl;
  String? audioUrl;
  int? testId;
  int partId;

  QuestionResponse(this.id, this.questions, this.answers, this.imageUrl,
      this.audioUrl, this.testId, this.partId);

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      (json['question_id'] as num).toInt(),
      (json['questions'] as List<dynamic>).map((e) => e as String).toList(),
      (json['answers'] as List<dynamic>)
          .map((e) => AnswerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageurl'] as String?,
      json['audiourl'] as String?,
      (json['test_id'] as num?)?.toInt(),
      (json['part_id'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'question_id': id,
      'questions': questions,
      'answers': answers.map(
        (e) => e.toJson(),
      ),
      'imageurl': imageUrl,
      'audiourl': audioUrl,
      'test_id': testId,
      'part_id': partId,
    };
  }
}
