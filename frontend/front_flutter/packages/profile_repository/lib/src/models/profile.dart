import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  static const empty = Profile(
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
