part of 'questions_by_part_bloc.dart';

@immutable
sealed class QuestionsByPartEvent {}

class LoadQuestions extends QuestionsByPartEvent {
  GetQuestionsByPartObject object;

  LoadQuestions(this.object);
}
