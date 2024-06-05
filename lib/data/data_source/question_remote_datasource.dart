import 'package:ez_english/config/constants.dart';
import 'package:ez_english/data/request/get_question_by_part_request.dart';
import 'package:ez_english/data/response/question_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class QuestionRemoteDataSouce {
  Future<List<QuestionResponse>> getQuestionByPart(
      GetQuestionByPartRequest request);
}

class QuestionRemoteDateSouceImpl implements QuestionRemoteDataSouce {
  final SupabaseClient supabaseClient;

  QuestionRemoteDateSouceImpl(this.supabaseClient);

  @override
  Future<List<QuestionResponse>> getQuestionByPart(
      GetQuestionByPartRequest request) async {
    debugPrint("${request.skill} ${request.partIndex}");
    try {
      final response = await supabaseClient
          .from(QUESTION_TABLE)
          .select('* , part!question_part_id_fkey!inner(*)')
          .eq('part.skill', request.skill)
          .eq('part.part_index', request.partIndex);
      /*final response =
          await supabaseClient.from(QUESTION_TABLE).select('* ,choice(*)');*/
      debugPrint(response.first.toString());

      List<QuestionResponse> questionList =
          response.map((e) => QuestionResponse.fromJson(e)).toList();
      if (questionList.isEmpty) {
        throw Exception(emptyError);
      }
      return questionList;
    } catch (e) {
      rethrow;
    }
  }
}
