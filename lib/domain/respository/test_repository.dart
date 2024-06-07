import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/domain/model/test_question.dart';

abstract class TestRepository {
  Future<Either<Failure, List<TestCategory>>> getAllTestCategories();
  Future<Either<Failure, List<Test>>> getAllTestByCategory(int categoryId);
  Future<Either<Failure, List<TestQuestion>>> getQuestionsByPartTest(
      int testId, int partIndex , String skill);
}
