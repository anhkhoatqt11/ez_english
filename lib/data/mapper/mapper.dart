import 'package:ez_english/data/response/answer_response.dart';
import 'package:ez_english/data/response/part_response.dart';
import 'package:ez_english/data/response/question_response.dart';
import 'package:ez_english/domain/model/answer.dart';
import 'package:ez_english/domain/model/choice.dart';
import 'package:ez_english/domain/model/question.dart';
import 'package:flutter/foundation.dart';

import '../../domain/model/part.dart';

extension PartResponseMapper on PartResponse {
  Part toPart() {
    return Part(id, partIndex, skill);
  }
}

extension QuestionResponseMapper on QuestionResponse {

  Question toQuestion() {
    List<Answer> answerList = answers.map((e) => e.toAnswer()).toList();
    return Question(id, questions, answerList, imageUrl, audioUrl, testId, partId);
  }
}

extension AnswerResponseMapper on AnswerResponse {
  Answer toAnswer() {
    return Answer(answers, explanation, correctAnswer);
  }
}