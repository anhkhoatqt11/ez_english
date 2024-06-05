import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';

import '../model/question.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<Question>>> getQuestionByPart(
      int part, String skill, int limit);
}
