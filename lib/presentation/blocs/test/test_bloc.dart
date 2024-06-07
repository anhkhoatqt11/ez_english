import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:ez_english/domain/usecase/get_all_test_categories_usecase.dart';
import 'package:ez_english/domain/usecase/get_questions_by_part_usecase.dart';
import 'package:ez_english/domain/usecase/get_test_questions_by_part_usecase.dart';
import 'package:ez_english/domain/usecase/get_tests_by_category_usecase.dart';
import 'package:ez_english/presentation/common/objects/get_test_question_object.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  GetAllTestCategoriesUseCase getAllTestCategories;
  GetTestsByCategoryUseCase getTestsByCategory;
  GetTestQuestionsByPartUseCase getTestQuestionsByPartUseCase;

  TestBloc(this.getAllTestCategories, this.getTestsByCategory,
      this.getTestQuestionsByPartUseCase)
      : super(TestInitial()) {
    on<LoadTestCategory>(_onLoadTestCategory);
    on<LoadTestsByCategory>(_onLoadTestByCategory);
    on<LoadTestQuestionsByPartTest>(_onLoadTestQuestionByPartTest);
  }

  Future<FutureOr<void>> _onLoadTestCategory(
      LoadTestCategory event, Emitter<TestState> emit) async {
    emit(TestCategoryLoadingState());
    (await getAllTestCategories.execute(null)).fold(
        (l) => emit(TestCategoryErrorState(l)),
        (r) => emit(TestCategoryLoadedState(r)));
  }

  Future<FutureOr<void>> _onLoadTestByCategory(
      LoadTestsByCategory event, Emitter<TestState> emit) async {
    emit(TestLoadingState());
    (await getTestsByCategory.execute(event.categoryId))
        .fold((l) => emit(TestErrorState(l)), (r) => emit(TestLoadedState(r)));
  }

  Future<FutureOr<void>> _onLoadTestQuestionByPartTest(
      LoadTestQuestionsByPartTest event, Emitter<TestState> emit) async {
    emit(TestQuestionLoadingState());
    (await getTestQuestionsByPartUseCase.execute(
            GetTestQuestionObject(event.testId, event.partIndex, event.skill)))
        .fold(
      (l) => emit(TestQuestionErrorState(l)),
      (r) => emit(TestQuestionLoadedState(r)),
    );
  }
}
