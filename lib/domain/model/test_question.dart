import 'package:ez_english/domain/model/answer.dart';

class TestQuestion {
  int id;
  DateTime createdAt;
  List<String> question;
  List<Answer> answer;
  String? imageUrl;
  String? audioUrl;
  int? testId;
  int partId;

  TestQuestion(this.id, this.createdAt, this.question, this.answer,
      this.imageUrl, this.audioUrl, this.testId, this.partId);
}
