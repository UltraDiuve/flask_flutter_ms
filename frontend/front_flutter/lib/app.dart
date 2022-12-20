import 'package:authentication_repository/authentication_repository.dart';
import 'package:elpmi_profile_repository/elpmi_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_flutter/routing/routes.dart';
import 'package:profile_repository/profile_repository.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'elpmi_profile/bloc/elpmi_profile_bloc.dart';
import 'profiles/bloc/profiles_bloc.dart';
// import 'screens/profile_list_screen.dart';
import 'package:flow_builder/flow_builder.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required ProfileRepository profileRepository,
    required AuthenticationRepository authenticationRepository,
    required ElpmiProfileRepository elpmiProfileRepository,
  })  : _profileRepository = profileRepository,
        _authenticationRepository = authenticationRepository,
        _elpmiProfileRepository = elpmiProfileRepository;

  final ProfileRepository _profileRepository;
  final AuthenticationRepository _authenticationRepository;
  final ElpmiProfileRepository _elpmiProfileRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProfileRepository>(
            create: (context) => _profileRepository),
        RepositoryProvider<AuthenticationRepository>(
            create: (context) => _authenticationRepository),
        RepositoryProvider<ElpmiProfileRepository>(
            create: (context) => _elpmiProfileRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          const BlocProvider<ProfilesBloc>(create: startProfilesBloc),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                authenticationRepository:
                    context.read<AuthenticationRepository>()),
          ),
          BlocProvider<ElpmiProfileBloc>(
            create: (context) => ElpmiProfileBloc(
                elpmiProfileRepository: _elpmiProfileRepository),
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
