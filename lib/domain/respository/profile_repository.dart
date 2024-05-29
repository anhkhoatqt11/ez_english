import 'package:dartz/dartz.dart';
import 'package:ez_english/domain/model/profile.dart';

import '../../data/network/failure.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getUserProfile(String uuid);
}
