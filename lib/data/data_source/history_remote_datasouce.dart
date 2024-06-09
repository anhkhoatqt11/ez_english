import 'package:ez_english/data/request/history_request.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HistoryRemoteDataSource {
  Future<void> saveInHistory(HistoryRequest request);
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  SupabaseClient supabaseClient;

  HistoryRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> saveInHistory(HistoryRequest request) async {
    await supabaseClient.from("history").insert(request.toJson());
  }
}
