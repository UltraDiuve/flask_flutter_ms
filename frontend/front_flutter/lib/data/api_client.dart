import 'dart:convert' show json, jsonEncode;

import 'package:front_flutter/data/profile.dart';

import 'package:http/http.dart' as http;

class APIClient {
  final _host = 'http://piero-merguez.hd.free.fr:5000';

  Future<List<Profile>?> fetchProfiles() async {
    final response = await http.get(Uri.parse('$_host/profiles'));
    final data = json.decode(response.body);
    // debugPrint(
    //     data.map<Profile>(Profile.fromJson).toList(growable: false).toString());
    return data.map<Profile>(Profile.fromJson).toList(growable: false);
  }

  Future<List<Profile>?> postProfile() async {
    final response = await http.post(
      Uri.parse('$_host/profiles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    final data = json.decode(response.body);
    return data.map<Profile>(Profile.fromJson).toList(growable: false);
    ;
  }
}
