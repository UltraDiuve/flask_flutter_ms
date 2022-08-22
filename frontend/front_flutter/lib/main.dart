// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front_flutter/bloc/bloc_provider.dart';
import 'package:front_flutter/bloc/profile_list_bloc.dart';
import 'package:front_flutter/screens/profile_list_screen.dart';

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
          primarySwatch: Colors.blue,
        ),
        home: const ProfileListPage(title: 'API Call'),
      ),
    );
  }
}
