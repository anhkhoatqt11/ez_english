import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:flutter/cupertino.dart';

class TestInheritedWidget extends InheritedWidget {
  final List<String?> skills;
  final Test test;


  const TestInheritedWidget({super.key, required super.child , required this.skills, required this.test});

  @override
  bool updateShouldNotify(covariant TestInheritedWidget oldWidget) {
    return oldWidget.skills != skills || oldWidget.test != test;
  }


  static TestInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TestInheritedWidget>();
  }

}