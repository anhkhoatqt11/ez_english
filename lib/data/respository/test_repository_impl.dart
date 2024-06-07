import 'package:dartz/dartz.dart';
import 'package:ez_english/data/data_source/test_remote_datasource.dart';
import 'package:ez_english/data/mapper/mapper.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/data/network/network_info.dart';
import 'package:ez_english/data/response/test_category_response.dart';
import 'package:ez_english/data/response/test_question_response.dart';
import 'package:ez_english/data/response/test_response.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:ez_english/domain/respository/test_repository.dart';

import '../../config/constants.dart';

class TestRepositoryImpl implements TestRepository {
  final TestRemoteDatasource testRemoteDatasource;
  final NetworkInfo networkInfo;

  TestRepositoryImpl(this.testRemoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, List<TestCategory>>> getAllTestCategories() async {
    try {
      if (await networkInfo.isConnected) {
        List<TestCategoryResponse> data =
            (await testRemoteDatasource.getAllTestCategories());
        return Right(data
            .map(
              (e) => e.toTestCategory(),
            )
            .toList());
      } else {
        return Left(Failure(noInternetError));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Test>>> getAllTestByCategory(
      int categoryId) async {
    try {
      if (await networkInfo.isConnected) {
        List<TestResponse> data =
            (await testRemoteDatasource.getAllTestByCategory(categoryId));
        return Right(data
            .map(
              (e) => e.toTest(),
            )
            .toList());
      } else {
        return Left(Failure(noInternetError));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TestQuestion>>> getQuestionsByPartTest(
      int testId, int partIndex , String skill) async {
    try {
      if (await networkInfo.isConnected) {
        List<TestQuestionResponse> data =
            (await testRemoteDatasource.getQuestionsByPartTest(testId, partIndex , skill));
        return Right(data
            .map(
              (e) => e.toTestQuestion(),
            )
            .toList());
      } else {
        return Left(Failure(noInternetError));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
