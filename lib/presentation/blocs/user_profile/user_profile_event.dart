part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class LoadUserProfileById extends UserProfileEvent {
  String uuid;

  LoadUserProfileById(this.uuid);
}
