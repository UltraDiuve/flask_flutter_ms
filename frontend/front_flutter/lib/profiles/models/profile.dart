import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:profile_repository/profile_repository.dart'
    as profile_repository;

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileAidantFromJson(json);

  factory Profile.fromRepository(profile_repository.Profile profile) {
    return Profile(
      name: profile.name,
      id: profile.id,
      city: profile.city,
    );
  }

  Map<String, dynamic> toJson() => _$ProfileAidantToJson(this);

  @override
  List<Object> get props => [id];

  final String name;
  final num id;
  final String city;
}
