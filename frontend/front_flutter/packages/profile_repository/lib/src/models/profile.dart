import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class RepoProfile extends Equatable {
  const RepoProfile({
    required this.id,
    required this.name,
    required this.city,
  });

  factory RepoProfile.fromJson(Map<String, dynamic> json) =>
      _$RepoProfileFromJson(json);

  Map<String, dynamic> toJson() => _$RepoProfileToJson(this);

  static const empty = RepoProfile(
    id: -1,
    name: '',
    city: '',
  );

  final String name;
  final num id;
  final String city;

  @override
  List<Object> get props => [id, name, city];
}
