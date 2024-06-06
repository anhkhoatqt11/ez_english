import 'package:ez_english/domain/model/test.dart';

class TestCategory {
  int id;
  DateTime createdAt;
  String name;
  List<Test> testList;

  TestCategory(this.id, this.createdAt, this.name, this.testList);
}
