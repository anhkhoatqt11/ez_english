import 'package:ez_english/config/constants.dart';
import 'package:ez_english/data/request/get_question_by_part_request.dart';
import 'package:ez_english/data/response/question_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../response/profile_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileResponse> getUserProfileById(String uuid);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDatasourceImpl(this.supabaseClient);

  @override
  Future<ProfileResponse> getUserProfileById(String uuid) async {
    try {
      final response = await supabaseClient
          .from(PROFILE_TABLE)
          .select('* , level:level_id(*)')
          .eq('uuid', uuid);
      /*final response =
          await supabaseClient.from(QUESTION_TABLE).select('* ,choice(*)');*/
      debugPrint(response.toString());
      ProfileResponse profileResponse =
          ProfileResponse.fromJson(response.first);
      return profileResponse;
    } catch (e) {
      rethrow;
    }
  }
}
