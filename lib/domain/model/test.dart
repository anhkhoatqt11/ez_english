import 'package:ez_english/domain/model/profile.dart';
import 'package:ez_english/domain/model/test_question.dart';

class Test {
  int id;
  DateTime createdAt;
  String name;
  String description;
  int time;
  int numOfQuestions;
  Level levelRequirement;

  Test(this.id, this.createdAt, this.name, this.description, this.time,
      this.numOfQuestions, this.levelRequirement);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Test && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
