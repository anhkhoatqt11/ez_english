part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class LoadTestCategory extends TestEvent {}

class LoadTestsByCategory extends TestEvent {
  int categoryId;

  LoadTestsByCategory(this.categoryId);
}

class LoadTestQuestionsByPartTest extends TestEvent {
  int testId;
  int partIndex;
  String skill;

  LoadTestQuestionsByPartTest(this.testId, this.partIndex , this.skill);
}
