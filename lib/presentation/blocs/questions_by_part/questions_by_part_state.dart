part of 'questions_by_part_bloc.dart';

@immutable
sealed class QuestionsByPartState {}

final class QuestionsByPartInitial extends QuestionsByPartState {}

class QuestionsByPartLoadingState extends QuestionsByPartState {}

class QuestionsByPartSuccessState extends QuestionsByPartState {
  List<Question> questionList;

  QuestionsByPartSuccessState(this.questionList);
}

class QuestionsByPartErrorState extends QuestionsByPartState {
  Failure failure;

  QuestionsByPartErrorState(this.failure);
}
