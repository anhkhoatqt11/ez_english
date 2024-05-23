import 'package:ez_english/domain/model/answer.dart';

class Question {
  int id;
  List<String> questions;
  List<Answer> answers;

  String? imageUrl;

  String? audioUrl;

  int? testId;

  int partId;

  Question(this.id, this.questions, this.answers, this.imageUrl, this.audioUrl,
      this.testId, this.partId);
}