import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_flutter/routing/routes.dart';
import 'package:profile_repository/profile_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'profiles/bloc/profiles_bloc.dart';
// import 'screens/profile_list_screen.dart';
import 'package:flow_builder/flow_builder.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required ProfileRepository profileRepository,
      required AuthenticationRepository authenticationRepository})
      : _profileRepository = profileRepository,
        _authenticationRepository = authenticationRepository;

  final ProfileRepository _profileRepository;
  final AuthenticationRepository _authenticationRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProfileRepository>(
            create: (context) => _profileRepository),
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => _authenticationRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          const BlocProvider<ProfilesBloc>(create: startProfilesBloc),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>()),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'API Call',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FlowBuilder<AuthenticationStatus>(
            state:
                context.select((AuthenticationBloc bloc) => bloc.state.status),
            onGeneratePages: onGenerateAppViewPages));
  }
}

ProfilesBloc startProfilesBloc(BuildContext context) {
  final bloc =
      ProfilesBloc(profileRepository: context.read<ProfileRepository>());
  bloc.add(RefreshProfiles());
  return bloc;
}
