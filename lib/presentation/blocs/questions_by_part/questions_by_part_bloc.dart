import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/presentation/common/objects/get_questions_by_part_object.dart';
import 'package:meta/meta.dart';

import '../../../domain/model/question.dart';
import '../../../domain/usecase/get_questions_by_part_usecase.dart';

part 'questions_by_part_event.dart';
part 'questions_by_part_state.dart';

class QuestionsByPartBloc
    extends Bloc<QuestionsByPartEvent, QuestionsByPartState> {
  GetQuestionsByPartUseCase getQuestionsByPartUseCase;

  QuestionsByPartBloc(this.getQuestionsByPartUseCase)
      : super(QuestionsByPartInitial()) {
    on<LoadQuestions>(_onLoadQuestions);
  }

  Future<FutureOr<void>> _onLoadQuestions(
      LoadQuestions event, Emitter<QuestionsByPartState> emit) async {
    emit(QuestionsByPartLoadingState());
    (await getQuestionsByPartUseCase.execute(event.object)).fold(
        (l) => emit(QuestionsByPartErrorState(l)),
        (r) => emit(QuestionsByPartSuccessState(r)));
  }
}
