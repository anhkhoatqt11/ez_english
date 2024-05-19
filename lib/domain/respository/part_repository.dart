import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/part.dart';
import 'package:dartz/dartz.dart';

abstract class PartRepository {
  Future<Either<Failure, List<Part>>> getPartBySkill(String skill);
}
