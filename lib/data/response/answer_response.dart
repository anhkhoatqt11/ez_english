class AnswerResponse {
  List<String> answers;
  String? explanation;
  int correctAnswer;

  AnswerResponse(this.answers, this.explanation, this.correctAnswer);

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return AnswerResponse(
      (json['answers'] as List<dynamic>).map((e) {
        return e as String;
      }).toList(),
      json['explanation'] as String?,
      (json['correct_answer'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'answers': answers,
      'explanation': explanation,
      'correct_answer': correctAnswer,
    };
  }
}
