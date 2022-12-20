import 'package:flutter/widgets.dart';
// import 'package:flutter_firebase_login/app/app.dart';
// import 'package:flutter_firebase_login/home/home.dart';
import 'package:front_flutter/login/login.dart';
import 'package:front_flutter/authentication/authentication.dart';
import 'package:front_flutter/screens/profile_list_screen.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthenticationStatus.unauthenticated:
      return [LoginPage.page()];
    case AuthenticationStatus.authenticated:
      return [ProfileListPage.page()];
  }
}
