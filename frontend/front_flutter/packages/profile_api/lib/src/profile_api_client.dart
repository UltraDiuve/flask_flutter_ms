// import 'dart:convert' show json, jsonEncode;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:profile_api/profile_api.dart';

/// Exception thrown when fetchProfiles fails.
class ProfilesFetchRequestFailure implements Exception {}

class ProfileApiClient {
  ProfileApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'http://piero-merguez.hd.free.fr';
  final http.Client _httpClient;

  Future<List<ApiProfile>?> fetchProfiles() async {
    print("Start of API fetching profiles...");

    final response = await _httpClient.get(Uri.parse('$_baseUrl/profiles'));

    print(
        "End of API profiles fetching: ${response.body} ${response.statusCode}");

    if (response.statusCode != 200) {
      throw ProfilesFetchRequestFailure();
    }
    final data = jsonDecode(response.body);
    return data
        .map<ApiProfile>((json) => ApiProfile.fromJson(json))
        .toList(growable: false);
  }

  Future<List<ApiProfile>?> postProfile() async {
    final response = await _httpClient.post(
      Uri.parse('$_baseUrl/profiles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    final data = json.decode(response.body);
    return data
        .map<ApiProfile>((json) => ApiProfile.fromJson(json))
        .toList(growable: false);
  }
}
