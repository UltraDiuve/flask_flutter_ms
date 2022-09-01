// import 'dart:convert' show json, jsonEncode;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:profile_api/profile_api.dart';

class ProfileApiClient {
  ProfileApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'http://piero-merguez.hd.free.fr';
  final http.Client _httpClient;

  Future<List<Profile>?> fetchProfiles() async {
    final response = await _httpClient.get(Uri.parse('$_baseUrl/profiles'));
    final data = jsonDecode(response.body);
    // debugPrint(
    //     data.map<Profile>(Profile.fromJson).toList(growable: false).toString());
    return data
        .map<Profile>((json) => Profile.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Profile>?> postProfile() async {
    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/profiles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    final data = json.decode(response.body);
    return data.map<Profile>(Profile.fromJson).toList(growable: false);
  }
}
