import 'dart:convert' show json;

import 'package:front_flutter/data/profile.dart';

import 'package:http/http.dart' as http;

class APIClient {
  final _host = 'http://127.0.0.1:5000';

  Future<List<Profile>?> fetchProfiles() async {
    final response = await http.get(Uri.parse('$_host/profiles'));
    final data = json.decode(response.body);
    // debugPrint(
    //     data.map<Profile>(Profile.fromJson).toList(growable: false).toString());
    return data.map<Profile>(Profile.fromJson).toList(growable: false);
  }
}
