import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Call',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'API Call'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  void _refreshList() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: _buildProfileList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshList,
        tooltip: 'Call API',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildProfileList() {
    return const Center(
        child: Text(
      'No result',
      style: TextStyle(fontSize: 25),
    ));
  }
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