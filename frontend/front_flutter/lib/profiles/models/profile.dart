import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:profile_repository/profile_repository.dart'
    as profile_repository;

part 'profile.g.dart';

@JsonSerializable()
class BlocProfile extends Equatable {
  const BlocProfile({
    required this.id,
    required this.name,
    required this.city,
  });

  factory BlocProfile.fromJson(Map<String, dynamic> json) =>
      _$BlocProfileFromJson(json);

  factory BlocProfile.fromRepository(profile_repository.RepoProfile profile) {
    return BlocProfile(
      name: profile.name,
      id: profile.id,
      city: profile.city,
    );
  }

  static const empty = BlocProfile(
    id: -1,
    name: 'EMPTY',
    city: 'EMPTY',
  );

  Map<String, dynamic> toJson() => _$BlocProfileToJson(this);

  @override
  List<Object> get props => [id];

  final String name;
  final num id;
  final String city;
}
