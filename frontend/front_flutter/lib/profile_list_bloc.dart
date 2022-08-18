import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'data/api_client.dart';
import 'data/profile.dart';

class ProfileListBloc implements Bloc {
  final _client = APIClient();
  final _profileCallController = StreamController<bool?>();
  Sink<bool?> get callTrigger => _profileCallController.sink;
  late Stream<List<Profile>?> profilesStream;

  ProfileListBloc() {
    profilesStream = _profileCallController.stream.startWith(true).switchMap(
        (event) => _client.fetchProfiles().asStream().startWith(null));
  }

  @override
  void dispose() {
    _profileCallController.close();
  }
}
