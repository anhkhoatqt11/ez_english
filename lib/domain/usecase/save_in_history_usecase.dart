import 'package:dartz/dartz.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/respository/history_repository.dart';
import 'package:ez_english/domain/usecase/base_usecase.dart';
import 'package:ez_english/presentation/common/objects/history_object.dart';

class SaveInHistoryUseCase extends BaseUseCase<HistoryObject, void> {
  HistoryRepository historyRepository;

  SaveInHistoryUseCase(this.historyRepository);

  @override
  Future<Either<Failure, void>> execute(HistoryObject input) {
    return historyRepository.saveInHistory(input);
  }
}
