import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/respository/test_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';

class GetTestsByCategoryUseCase extends BaseUseCase<int, List<Test>> {
  TestRepository testRepository;

  GetTestsByCategoryUseCase(this.testRepository);

  @override
  Future<Either<Failure, List<Test>>> execute(int input) {
    return testRepository.getAllTestByCategory(input);
  }
}
