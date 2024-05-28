part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileLoadedState extends UserProfileState {
  Profile profile;

  UserProfileLoadedState(this.profile);
}

class UserProfileErrorState extends UserProfileState {
  Failure failure;

  UserProfileErrorState(this.failure);
}
