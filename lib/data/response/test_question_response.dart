import 'answer_response.dart';

class TestQuestionResponse {
  int id;
  DateTime createdAt;
  List<String> question;
  List<AnswerResponse> answer;
  String? imageUrl;
  String? audioUrl;
  int? testId;
  int partId;

  TestQuestionResponse(this.id, this.createdAt, this.question, this.answer,
      this.imageUrl, this.audioUrl, this.testId, this.partId);

  factory TestQuestionResponse.fromJson(Map<String, dynamic> json) {
    return TestQuestionResponse(
      json['id'] as int,
      DateTime.parse(json['created_at'] as String),
      List<String>.from(json['question'] as List),
      (json['answer'] as List<dynamic>)
          .map((e) => AnswerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['imageUrl'] as String?,
      json['audioUrl'] as String?,
      json['test_id'] as int?,
      json['part_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'question': question,
      'answer': answer.map((e) => e.toJson()).toList(),
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'test_id': testId,
      'part_id': partId,
    };
  }

  @override
  String toString() {
    return 'TestQuestionResponse{id: $id, createdAt: $createdAt, question: $question, answer: $answer, imageUrl: $imageUrl, audioUrl: $audioUrl, testId: $testId, partId: $partId}';
  }
}
