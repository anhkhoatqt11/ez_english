import 'package:dartz/dartz.dart';
import 'package:ez_english/data/data_source/question_remote_datasource.dart';
import 'package:ez_english/data/mapper/mapper.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/data/network/network_info.dart';
import 'package:ez_english/data/request/get_question_by_part_request.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:ez_english/domain/respository/question_repository.dart';

import '../../config/constants.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSouce questionRemoteDataSouce;
  final NetworkInfo networkInfo;

  QuestionRepositoryImpl(this.questionRemoteDataSouce, this.networkInfo);

  @override
  Future<Either<Failure, List<Question>>> getQuestionByPart(
      int part, String skill) async {
    List<Question> questionList = (await questionRemoteDataSouce
            .getQuestionByPart(GetQuestionByPartRequest(part, skill)))
        .map((e) => e.toQuestion())
        .toList();
    return Right(questionList);

    try {
      if (await networkInfo.isConnected) {
        List<Question> questionList = (await questionRemoteDataSouce
                .getQuestionByPart(GetQuestionByPartRequest(part, skill)))
            .map((e) => e.toQuestion())
            .toList();
        return Right(questionList);
      } else {
        return Left(Failure(noInternetError));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
