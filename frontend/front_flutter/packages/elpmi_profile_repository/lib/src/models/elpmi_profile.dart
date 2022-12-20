import 'package:equatable/equatable.dart';

class ElpmiProfile extends Equatable {
  /// {@macro user}
  const ElpmiProfile({
    required this.uid,
    this.userEmail,
    this.name,
    this.photoUrl,
    this.birthDate,
    this.gender,
    this.occupation,
    this.experience,
    this.mentalLoad,
    this.helperBio,
    this.longitude,
    this.latitude,
    this.streetNum,
    this.street,
    this.zipCode,
    this.city,
    this.country,
  });

  final String uid;
  final String? name;
  final String? photoUrl;
  final DateTime? birthDate;
  final String? gender;
  final String? occupation;
  final String? userEmail;
  final String? experience;
  final String? mentalLoad;
  final String? helperBio;
  final String? longitude;
  final String? latitude;
  final String? streetNum;
  final String? street;
  final String? zipCode;
  final String? city;
  final String? country;

  /// Empty user which represents an unauthenticated user.
  static const empty = ElpmiProfile(uid: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == ElpmiProfile.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != ElpmiProfile.empty;

  factory ElpmiProfile.fromMap(Map<String, dynamic> map) => ElpmiProfile(
        uid: map['uid'],
        userEmail: map['userEmail'],
        name: map['name'],
        photoUrl: map['photoUrl'],
        birthDate: map['birthDate'],
        gender: map['gender'],
        occupation: map['occupation'],
        experience: map['experience'],
        mentalLoad: map['mentalLoad'],
        helperBio: map['helperBio'],
        longitude: map['longitude'],
        latitude: map['latitude'],
        streetNum: map['streetNum'],
        street: map['street'],
        zipCode: map['zipCode'],
        city: map['city'],
        country: map['country'],
      );

  @override
  List<Object?> get props => [uid, name, photoUrl];
}
