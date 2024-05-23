import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:ez_english/domain/respository/question_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';

class GetQuestionsByPartUseCase extends BaseUseCase<GetQuestionsByPartObject , List<Question>> {

  final QuestionRepository questionRepository;


  GetQuestionsByPartUseCase(this.questionRepository);

  @override
  Future<Either<Failure, List<Question>>> execute(GetQuestionsByPartObject input) {
    return questionRepository.getQuestionByPart(input.part, input.skill);
  }

}