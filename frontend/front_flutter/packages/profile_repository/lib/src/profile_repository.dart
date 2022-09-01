import 'dart:async';

import 'package:profile_api/profile_api.dart' as profile_api; // hide Profile
import 'package:profile_repository/profile_repository.dart';

class ProfileFailure implements Exception {}

class ProfileRepository {
  ProfileRepository({profile_api.ProfileApiClient? profileApiClient})
      : _profileApiClient = profileApiClient ?? profile_api.ProfileApiClient();

  final profile_api.ProfileApiClient _profileApiClient;

  Future<List<Profile>?> getProfiles() async {
    final List<profile_api.Profile>? apiProfiles =
        await _profileApiClient.fetchProfiles();
    return apiProfiles?.map(_apiProfileToRepoProfile).toList();
  }

  Profile _apiProfileToRepoProfile(profile_api.Profile apiProfile) {
    return Profile(
      city: apiProfile.city,
      name: apiProfile.name,
      id: apiProfile.id,
    );
  }

  Future<List<Profile>?> addProfile() async {
    final List<profile_api.Profile>? apiProfiles =
        await _profileApiClient.postProfile();
    return apiProfiles?.map(_apiProfileToRepoProfile).toList();
  }
}
