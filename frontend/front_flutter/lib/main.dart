// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:front_flutter/profiles/bloc/profiles_bloc.dart';
// import 'package:front_flutter/screens/profile_list_screen.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:elpmi_profile_repository/elpmi_profile_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
// import 'authentication/bloc/authentication_bloc.dart';
import 'authentication/bloc_observer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(App(
    profileRepository: ProfileRepository(),
    authenticationRepository: AuthenticationRepository(),
    elpmiProfileRepository: ElpmiProfileRepository(),
  ));
}
