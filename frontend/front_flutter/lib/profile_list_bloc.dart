import 'dart:async';

import 'bloc.dart';
import 'data/api_client.dart';
import 'data/profile.dart';

class ProfileListBloc implements Bloc {
  final _client = APIClient();
  final _profileCallController = StreamController<bool?>();
  Sink<bool?> get callTrigger => _profileCallController.sink;
  late Stream<List<Profile>?> profilesStream;

  ProfileListBloc() {
    profilesStream = _profileCallController.stream
        .asyncMap((event) => _client.fetchProfiles());
  }

  @override
  void dispose() {
    _profileCallController.close();
  }
}
