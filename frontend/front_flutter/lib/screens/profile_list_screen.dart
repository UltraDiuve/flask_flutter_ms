import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front_flutter/authentication/bloc/authentication_bloc.dart';
import 'package:front_flutter/widgets/floating_action_buttons.dart';
import 'package:front_flutter/profiles/bloc/profiles_bloc.dart';
import 'package:front_flutter/profiles/models/profile.dart';
// import 'package:front_flutter/bloc/bloc_provider.dart';
// import 'package:front_flutter/packages/profile_api/lib/src/models/profile.dart';
// import 'package:front_flutter/bloc/profile_list_bloc.dart';

class ProfileListPage extends StatefulWidget {
  const ProfileListPage({Key? key, required this.title}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(
          child: ProfileListPage(
        title: "Profile list",
      ));

  final String title;

  @override
  State<ProfileListPage> createState() => _ProfileListPageState();
}

class _ProfileListPageState extends State<ProfileListPage> {
  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<ProfileListBloc>(context);
    // bloc.callTrigger.add(true);

    return BlocBuilder<ProfilesBloc, ProfilesState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.logout,
                      size: 26.0,
                    ),
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AppLogoutRequested());
                    },
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: (() {
                context.read<ProfilesBloc>().add(RefreshProfiles());
                return Future(() => null);
              }),
              child: _buildProfileList(context, state),
            ),
            floatingActionButton: SingleOrMultipleFloatingActionButtons(
                infos: _createActionButtonInfoList(context)));
      },
    );

    // _onlyOnWeb(FloatingActionButton(
    //   onPressed: () {
    //     // debugPrint("Button clicked...");
    //     // debugPrint(APIClient().fetchProfiles().toString());
    //     bloc.callTrigger.add(true);
    //   },
    //   tooltip: 'Call API',
    //   child: const Icon(Icons.refresh),
  }

  Widget _buildProfileList(BuildContext context, ProfilesState state) {
    switch (state.status) {
      case ProfilesStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case ProfilesStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case ProfilesStatus.failure:
        return const Center(child: Text("ERROR !"));
      case ProfilesStatus.success:
        return _buildPopulatedProfileList(state.profiles);
    }

    // return StreamBuilder<List<Profile>?>(
    //     stream: bloc.profilesStream,
    //     builder: (context, snapshot) {
    //       final results = snapshot.data;
    //       if (results == null) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (results.isEmpty) {
    //         return const Center(
    //             child: Text(
    //           'No result',
    //           style: TextStyle(fontSize: 25),
    //         ));
    //       } else {
    //         return _buildPopulatedProfileList(results);
    //       }
    //     });
  }
}

Widget _buildPopulatedProfileList(List<BlocProfile> profiles) {
  return ListView.builder(
    itemCount: profiles.length,
    itemBuilder: (context, index) {
      return Card(
          elevation: 6,
          margin: const EdgeInsets.all(5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(profiles[index].id.toString()),
            ),
            title: Text(profiles[index].name),
            onTap: () {
              debugPrint(profiles[index].name);
            },
          ));
    },
  );
}

List<FloatingActionButtonInfo> _createActionButtonInfoList(
    BuildContext context) {
  if (kIsWeb) {
    return ([
      FloatingActionButtonInfo(
        label: 'Refresh',
        icon: const Icon(Icons.refresh),
        onPressed: () {
          context.read<ProfilesBloc>().add(RefreshProfiles());
        },
      ),
      FloatingActionButtonInfo(
        label: 'Add Profile',
        icon: const Icon(Icons.add),
        onPressed: () {
          context.read<ProfilesBloc>().add(CreateProfile());
        },
      ),
    ]);
  } else {
    return ([
      FloatingActionButtonInfo(
        label: 'Add Profile',
        icon: const Icon(Icons.add),
        onPressed: () {
          context.read<ProfilesBloc>().add(CreateProfile());
        },
      ),
    ]);
  }
}
