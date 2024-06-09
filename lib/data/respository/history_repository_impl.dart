import 'package:dartz/dartz.dart';
import 'package:ez_english/config/constants.dart';
import 'package:ez_english/data/data_source/history_remote_datasouce.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/data/network/network_info.dart';
import 'package:ez_english/data/request/history_request.dart';
import 'package:ez_english/domain/respository/history_repository.dart';
import 'package:ez_english/presentation/common/objects/history_object.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRemoteDataSource historyRemoteDataSource;
  NetworkInfo networkInfo;

  HistoryRepositoryImpl(this.historyRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, void>> saveInHistory(HistoryObject object) async {
    if (await networkInfo.isConnected) {
      historyRemoteDataSource.saveInHistory(HistoryRequest(object.createdAt,
          object.testId, object.score, object.isComplete, object.userId));
      return const Right(null);
    } else {
      return Left(Failure(noInternetError));
    }
  }
}
