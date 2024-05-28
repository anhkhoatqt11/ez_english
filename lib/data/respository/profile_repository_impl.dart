import 'package:dartz/dartz.dart';
import 'package:ez_english/data/data_source/profile_remote_datasource.dart';
import 'package:ez_english/data/mapper/mapper.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/profile.dart';
import 'package:ez_english/domain/respository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;

  ProfileRepositoryImpl(this.profileRemoteDatasource);

  @override
  Future<Either<Failure, Profile>> getUserProfile(String uuid) async {
    try {
      var data = await profileRemoteDatasource.getUserProfileById(uuid);
      return Right(data.toProfile());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
