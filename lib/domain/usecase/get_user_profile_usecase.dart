import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/profile.dart';
import 'package:ez_english/domain/respository/profile_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';

class GetUserProfileUsecase extends BaseUseCase<String, Profile> {
  final ProfileRepository profileRepository;

  GetUserProfileUsecase(this.profileRepository);

  @override
  Future<Either<Failure, Profile>> execute(String input) {
    return profileRepository.getUserProfile(input);
  }
}
