import 'package:ez_english/data/response/test_response.dart';

class TestCategoryResponse {
  int id;
  DateTime createdAt;
  String name;
  List<TestResponse> testList;

  TestCategoryResponse(this.id, this.createdAt, this.name, this.testList);

  factory TestCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['test'] == null) {
      return TestCategoryResponse(
          json['id'] as int,
          DateTime.parse(json['created_at'] as String),
          json['name'] as String,
          List.empty(growable: true));
    }
    return TestCategoryResponse(
        json['id'] as int,
        DateTime.parse(json['created_at'] as String),
        json['name'] as String,
        (json['test'] as List<dynamic>)
            .map(
              (e) => TestResponse.fromJson(e),
            )
            .toList());
  }

  @override
  String toString() {
    return 'TestCategoryResponse{id: $id, createdAt: $createdAt, name: $name, testList: $testList}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
      'testList': testList.map(
        (e) => e.toJson(),
      )
    };
  }
}
