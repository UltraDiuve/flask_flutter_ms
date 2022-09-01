// import 'dart:async';
// import 'package:rxdart/rxdart.dart';

// import 'bloc.dart';
// // import '../../packages/profile_api/lib/src/api_client.dart';
// // import '../packages/profile_api/lib/src/models/profile.dart';

// class ProfileListBloc implements Bloc {
//   final _client = APIClient();
//   final _profileCallController = StreamController<String?>();
//   Sink<String?> get callTrigger => _profileCallController.sink;
//   late Stream<List<Profile>?> profilesStream;

//   ProfileListBloc() {
//     profilesStream =
//         _profileCallController.stream.startWith('refresh').switchMap((event) {
//       if (event == 'refresh') {
//         return (_client.fetchProfiles().asStream().startWith(null));
//       } else {
//         return (_client.postProfile().asStream().startWith(null));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _profileCallController.close();
//   }
// }
