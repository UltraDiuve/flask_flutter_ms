import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:front_flutter/profiles/profiles.dart';
import 'package:profile_repository/profile_repository.dart'
    show ProfileRepository;

part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  ProfilesBloc({required this.profileRepository}) : super(ProfilesInitial()) {
    on<ProfilesRefresh>(_getProfiles);
  }

  void _getProfiles(
    ProfilesRefresh event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(ProfilesState(
      status: ProfilesStatus.loading,
      profiles: List.empty(),
    ));
    try {
      final profileList = await profileRepository.getProfiles();
      emit(ProfilesState(
        status: ProfilesStatus.success,
        profiles: profileList?.map<Profile>(Profile.fromRepository).toList(),
      ));
    } on Exception {
      emit(ProfilesState(
        status: ProfilesStatus.failure,
        profiles: List.empty(),
      ));
    }
  }

  final ProfileRepository profileRepository;
}
