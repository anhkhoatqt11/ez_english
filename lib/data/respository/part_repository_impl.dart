import 'package:dartz/dartz.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/data/data_source/part_remote_datasource.dart';
import 'package:ez_english/data/mapper/mapper.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/part.dart';
import 'package:ez_english/domain/respository/part_repository.dart';

import '../network/network_info.dart';

class PartRepositoryImpl implements PartRepository {

  PartRemoteDataSource partRemoteDataSource;
  NetworkInfo networkInfo;

  PartRepositoryImpl(this.partRemoteDataSource , this.networkInfo);

  @override
  Future<Either<Failure, List<Part>>> getPartBySkill(String skill) async {
    try {
      if(await networkInfo.isConnected) {
        List<Part> partList = (await partRemoteDataSource.getPartBySkill(skill)).map((e) => e.toPart()).toList();
        return Right(partList);
      } else {
        return Left(Failure(noInternetError));
      }
    }
    catch(e) {
      return Left(Failure(e.toString()));
    }
  }

}