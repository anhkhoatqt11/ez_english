import 'choice.dart';

class Question {
  int id;
  String? title;
  String? correctLetter;
  String? imageUrl;
  String? audioUrl;
  int? testId;
  String? explanation;
  int? partId;
  List<Choice> choices;
  Question(this.id, this.title, this.correctLetter, this.imageUrl,
      this.audioUrl, this.testId, this.explanation, this.partId , this.choices);
}