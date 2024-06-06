part of 'test_bloc.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {}

class CategoryState extends TestState {}

class TestLoadingState extends TestState {}

class TestLoadedState extends TestState {
  List<Test> testList;

  TestLoadedState(this.testList);
}

class TestErrorState extends TestState {
  Failure failure;

  TestErrorState(this.failure);
}

class TestCategoryLoadedState extends CategoryState {
  List<TestCategory> testCategoryList;

  TestCategoryLoadedState(this.testCategoryList);
}

class TestCategoryErrorState extends CategoryState {
  Failure failure;

  TestCategoryErrorState(this.failure);
}

class TestCategoryLoadingState extends CategoryState {}
