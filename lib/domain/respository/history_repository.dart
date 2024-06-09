import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/presentation/common/objects/history_object.dart';

abstract class HistoryRepository {
  Future<Either<Failure, void>> saveInHistory(HistoryObject object);
}
