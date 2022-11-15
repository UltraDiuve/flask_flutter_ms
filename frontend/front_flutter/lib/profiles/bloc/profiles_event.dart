part of 'profiles_bloc.dart';

@immutable
abstract class ProfilesEvent {}

class RefreshProfiles extends ProfilesEvent {}

class CreateProfile extends ProfilesEvent {
  CreateProfile({BlocProfile? toCreate})
      : toCreate = toCreate ?? BlocProfile.empty;

  final BlocProfile toCreate;
}
