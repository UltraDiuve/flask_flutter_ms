import 'package:flutter/material.dart';
import 'package:front_flutter/bloc/bloc_provider.dart';
import 'package:front_flutter/data/profile.dart';
import 'package:front_flutter/profile_list_bloc.dart';

import 'data/api_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: ProfileListBloc(),
      child: MaterialApp(
        title: 'API Call',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const MyHomePage(title: 'API Call'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _buildProfileList(bloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // debugPrint("Button clicked...");
          // debugPrint(APIClient().fetchProfiles().toString());
          bloc.callTrigger.add(true);
        },
        tooltip: 'Call API',
        child: const Icon(Icons.refresh),
      ),
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

Widget _buildPopulatedProfileList(List<Profile> results) {
  return ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      return Card(
          elevation: 6,
          margin: const EdgeInsets.all(5),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(index.toString()),
            ),
            title: Text(results[index].name),
            onTap: () {
              debugPrint(results[index].name);
            },
          ));
    },
  );
}

// ListView.builder(
//         // Column is also a layout widget. It takes a list of children and
//         // arranges them vertically. By default, it sizes itself to fit its
//         // children horizontally, and tries to be as tall as its parent.
//         //
//         // Invoke "debug painting" (press "p" in the console, choose the
//         // "Toggle Debug Paint" action from the Flutter Inspector in Android
//         // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//         // to see the wireframe for each widget.
//         //
//         // Column has various properties to control how it sizes itself and
//         // how it positions its children. Here we use mainAxisAlignment to
//         // center the children vertically; the main axis here is the vertical
//         // axis because Columns are vertical (the cross axis would be
//         // horizontal).

//         itemCount: 10,
//         itemBuilder: (context, index) => Card(
//           elevation: 6,
//           margin: const EdgeInsets.all(10),
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.purple,
//               child: Text(index.toString()),
//             ),
//             title: Text("Salut zob $index"),
//             // subtitle: Text(dummyList[index]["subtitle"]),
//             // trailing: const Icon(Icons.add_a_photo),
//           ),
//         ),
//       ),