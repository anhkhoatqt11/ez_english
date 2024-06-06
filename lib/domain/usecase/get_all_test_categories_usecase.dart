import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/domain/respository/test_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';

class GetAllTestCategoriesUseCase
    extends BaseUseCase<void, List<TestCategory>> {
  TestRepository testRepository;

  GetAllTestCategoriesUseCase(this.testRepository);

  @override
  Future<Either<Failure, List<TestCategory>>> execute(void input) async {
    return await testRepository.getAllTestCategories();
  }
}
