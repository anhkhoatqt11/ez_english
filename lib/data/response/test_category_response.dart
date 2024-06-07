import 'package:ez_english/data/response/skill_response.dart';
import 'package:ez_english/data/response/test_response.dart';

class TestCategoryResponse {
  int id;
  DateTime createdAt;
  String name;
  List<TestResponse> testList;
  SkillResponse? skill1, skill2;

  TestCategoryResponse(this.id, this.createdAt, this.name, this.testList,
      this.skill1, this.skill2);

  factory TestCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['test'] == null) {
      return TestCategoryResponse(
          json['id'] as int,
          DateTime.parse(json['created_at'] as String),
          json['name'] as String,
          List.empty(growable: true),
          SkillResponse.fromJson(json['skill1']),
          SkillResponse.fromJson(json['skill2']));
    }
    return TestCategoryResponse(
        json['id'] as int,
        DateTime.parse(json['created_at'] as String),
        json['name'] as String,
        (json['test'] as List<dynamic>)
            .map(
              (e) => TestResponse.fromJson(e),
            )
            .toList(),
        SkillResponse.fromJson(json['skill1']),
        SkillResponse.fromJson(json['skill2']));
  }

  @override
  String toString() {
    return 'TestCategoryResponse{id: $id, createdAt: $createdAt, name: $name, testList: $testList}';
  }
}
