import 'package:audioplayers/audioplayers.dart';
import 'package:ez_english/app_prefs.dart';
import 'package:ez_english/data/data_source/question_remote_datasource.dart';
import 'package:ez_english/data/network/network_info.dart';
import 'package:ez_english/data/respository/question_repository_impl.dart';
import 'package:ez_english/domain/respository/question_repository.dart';
import 'package:ez_english/domain/usecase/get_questions_by_part_usecase.dart';
import 'package:ez_english/main.dart';
import 'package:ez_english/presentation/blocs/questions_by_part/questions_by_part_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _instance = GetIt.instance;
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  _instance.registerLazySingleton<AppPrefs>(() => AppPrefs(sharedPreferences));
  _instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  _instance.registerLazySingleton<QuestionRemoteDataSouce>(
      () => QuestionRemoteDateSouceImpl(supabase));

  initRepository();
}

initRepository() {
  if (!_instance.isRegistered<QuestionRepository>()) {
    _instance.registerLazySingleton<QuestionRepository>(
        () => QuestionRepositoryImpl(_instance(), _instance()));
  }
}

initQuestionPageModule() {
  if (!_instance.isRegistered<QuestionsByPartBloc>()) {
    _instance.registerLazySingleton<GetQuestionsByPartUseCase>(
        () => GetQuestionsByPartUseCase(_instance()));
    _instance.registerLazySingleton<QuestionsByPartBloc>(
        () => QuestionsByPartBloc(_instance()));
  }
}
