import 'package:ez_english/config/constants.dart';
import 'package:ez_english/data/response/part_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PartRemoteDataSource {
  Future<List<PartResponse>> getPartBySkill(String skill);
}

class PartRemoteDataSourceImpl implements PartRemoteDataSource {
  SupabaseClient supabaseClient;

  PartRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<PartResponse>> getPartBySkill(String skill) async {
    try {
      List<PartResponse> userList =
          (await supabaseClient.from(PART_TABLE).select().eq('skill', skill))
              .map((e) => PartResponse.fromJson(e))
              .toList();
      if (userList.isEmpty) {
        throw Exception(emptyError);
      }
      return userList;
    } catch (ex) {
      rethrow;
    }
  }
}
