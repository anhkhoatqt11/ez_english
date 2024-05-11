import 'package:ez_english/data/response/choice_response.dart';
import 'package:ez_english/data/response/part_response.dart';
import 'package:ez_english/data/response/question_response.dart';
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
    List<Choice> choiceList = choices.map((e) => e.toChoice()).toList();
    return Question(id, title, correctLetter, imageUrl, audioUrl, testId, explanation, partId , choiceList);
  }
}

extension ChoiceResponseMapper on ChoiceResponse {
  Choice toChoice() {
    return Choice(id, letter, content);
  }
}