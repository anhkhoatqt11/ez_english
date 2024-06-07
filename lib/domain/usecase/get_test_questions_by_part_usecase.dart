import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:ez_english/domain/respository/test_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';
import 'package:ez_english/presentation/common/objects/get_test_question_object.dart';

class GetTestQuestionsByPartUseCase
    extends BaseUseCase<GetTestQuestionObject, List<TestQuestion>> {
  TestRepository testRepository;

  GetTestQuestionsByPartUseCase(this.testRepository);

  @override
  Future<Either<Failure, List<TestQuestion>>> execute(
      GetTestQuestionObject input) {
    return testRepository.getQuestionsByPartTest(
        input.testId, input.partIndex, input.skill);
  }
}
