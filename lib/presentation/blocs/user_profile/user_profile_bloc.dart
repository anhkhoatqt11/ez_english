import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ez_english/data/network/failure.dart';
import 'package:ez_english/domain/model/profile.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecase/get_user_profile_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  GetUserProfileUsecase getUserProfileUsecase;

  UserProfileBloc(this.getUserProfileUsecase) : super(UserProfileInitial()) {
    on<LoadUserProfileById>(_onLoadById);
  }

  Future<FutureOr<void>> _onLoadById(
      LoadUserProfileById event, Emitter<UserProfileState> emit) async {
    emit(UserProfileLoadingState());
    (await getUserProfileUsecase.execute(event.uuid)).fold(
      (l) => emit(UserProfileErrorState(l)),
      (r) => emit(UserProfileLoadedState(r)),
    );
  }
}
