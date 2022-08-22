import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/UI/floating_action_buttons.dart';
import 'package:front_flutter/bloc/bloc_provider.dart';
import 'package:front_flutter/data/profile.dart';
import 'package:front_flutter/bloc/profile_list_bloc.dart';

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileListBloc>(context);
    // bloc.callTrigger.add(true);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RefreshIndicator(
        onRefresh: (() {
          bloc.callTrigger.add('refresh');
          return Future(() => null);
        }),
        child: _buildProfileList(bloc),
      ),
      floatingActionButton: SingleOrMultipleFloatingActionButtons(
          infos: _createActionButtonInfoList(bloc)),

      // _onlyOnWeb(FloatingActionButton(
      //   onPressed: () {
      //     // debugPrint("Button clicked...");
      //     // debugPrint(APIClient().fetchProfiles().toString());
      //     bloc.callTrigger.add(true);
      //   },
      //   tooltip: 'Call API',
      //   child: const Icon(Icons.refresh),
    );
  }

  Widget _buildProfileList(ProfileListBloc bloc) {
    return StreamBuilder<List<Profile>?>(
        stream: bloc.profilesStream,
        builder: (context, snapshot) {
          final results = snapshot.data;
          if (results == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (results.isEmpty) {
            return const Center(
                child: Text(
              'No result',
              style: TextStyle(fontSize: 25),
            ));
          } else {
            return _buildPopulatedProfileList(results);
          }
        });
  }
}

Widget _buildPopulatedProfileList(List<Profile> profiles) {
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
    ProfileListBloc bloc) {
  if (kIsWeb) {
    return ([
      FloatingActionButtonInfo(
        label: 'Refresh',
        icon: const Icon(Icons.refresh),
        onPressed: () {
          bloc.callTrigger.add('refresh');
        },
      ),
      FloatingActionButtonInfo(
        label: 'Add Profile',
        icon: const Icon(Icons.add),
        onPressed: () {
          bloc.callTrigger.add('add');
        },
      ),
    ]);
  } else {
    return ([
      FloatingActionButtonInfo(
        label: 'Add Profile',
        icon: const Icon(Icons.add),
        onPressed: () {
          bloc.callTrigger.add('add');
        },
      ),
    ]);
  }
}
