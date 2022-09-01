// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_flutter/profiles/bloc/profiles_bloc.dart';
import 'package:front_flutter/screens/profile_list_screen.dart';
import 'package:profile_repository/profile_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(profileRepository: ProfileRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _profileRepository,
      child: MaterialApp(
        title: 'API Call',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => ProfilesBloc(
              profileRepository: context.read<ProfileRepository>()),
          child: const ProfileListPage(title: 'API Call'),
        ),
      ),
    );
  }
}
