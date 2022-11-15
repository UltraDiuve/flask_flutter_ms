import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class ApiProfile {
  final String name;
  final num id;
  final String city;

  const ApiProfile({
    required this.id,
    required this.name,
    required this.city,
  });

  factory ApiProfile.fromJson(Map<String, dynamic> json) =>
      _$ApiProfileFromJson(json);
}
