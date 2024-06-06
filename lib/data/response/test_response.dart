import 'package:ez_english/data/response/profile_response.dart';
import 'package:ez_english/data/response/test_question_response.dart';

class TestResponse {
  int id;
  DateTime createdAt;
  String name;
  String description;
  int time;
  int numOfQuestions;
  LevelResponse levelRequirement;

  TestResponse(this.id, this.createdAt, this.name, this.description, this.time,
      this.numOfQuestions, this.levelRequirement);

  factory TestResponse.fromJson(Map<String, dynamic> json) {
    return TestResponse(
      json['id'] as int,
      DateTime.parse(json['created_at'] as String),
      json['name'] as String,
      json['description'] as String,
      json['time'] as int,
      json['num_of_questions'] as int,
      LevelResponse.fromJson(json['level']),
    );
  }

  @override
  String toString() {
    return 'TestResponse{id: $id, createdAt: $createdAt, name: $name, description: $description, time: $time, numOfQuestions: $numOfQuestions, levelRequirement: $levelRequirement}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'description': description,
      'time': time,
      'level_requirement': levelRequirement.toJson(),
    };
  }
}
