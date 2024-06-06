import 'package:ez_english/data/response/test_category_response.dart';
import 'package:ez_english/data/response/test_question_response.dart';
import 'package:ez_english/data/response/test_response.dart';
import 'package:ez_english/domain/model/test.dart';
import 'package:ez_english/domain/model/test_category.dart';
import 'package:ez_english/domain/model/test_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/constants.dart';

abstract class TestRemoteDatasource {
  Future<List<TestCategoryResponse>> getAllTestCategories();
  Future<List<TestResponse>> getAllTestByCategory(int categoryId);
  Future<List<TestQuestionResponse>> getQuestionsByPartTest(
      int testId, int partId);
}

class TestRemoteDatasourceImpl implements TestRemoteDatasource {
  final SupabaseClient supabaseClient;

  TestRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<List<TestCategoryResponse>> getAllTestCategories() async {
    try {
      final testCategoryResponse =
          await supabaseClient.from('test_category').select('*');

      // Fetch tests for each category
      List<TestCategoryResponse> testCategoryList = [];
      for (final category in testCategoryResponse) {
        List<TestResponse> testResponseList = [];
        final testResponse = await supabaseClient
            .from('test')
            .select('*, level(*)')
            .eq('category_id', category['id'])
            .limit(5);
        testResponseList.addAll(testResponse.map(
          (e) => TestResponse.fromJson(e),
        ));
        testCategoryList.add(TestCategoryResponse.fromJson(category)
          ..testList.addAll(testResponseList));
      }
      debugPrint(testCategoryList.toString());
      if (testCategoryList.isEmpty) {
        throw Exception(emptyError);
      }
      return testCategoryList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TestResponse>> getAllTestByCategory(int categoryId) async {
    try {
      final response = await supabaseClient
          .from("test")
          .select('* ,level(*)')
          .eq('category_id', categoryId);
      List<TestResponse> testList = response
          .map(
            (e) => TestResponse.fromJson(e),
          )
          .toList();
      debugPrint(testList.toString());
      return testList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TestQuestionResponse>> getQuestionsByPartTest(
      int testId, int partId) async {
    try {
      final response = await supabaseClient
          .from("test_question")
          .select('*')
          .eq('id', testId)
          .eq('part_id', partId);
      List<TestQuestionResponse> questionList = response
          .map(
            (e) => TestQuestionResponse.fromJson(e),
          )
          .toList();
      debugPrint(questionList.toString());
      return questionList;
    } catch (e) {
      rethrow;
    }
  }
}
