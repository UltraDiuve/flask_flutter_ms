// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoProfile _$RepoProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Profile',
      json,
      ($checkedConvert) {
        final val = RepoProfile(
          id: $checkedConvert('id', (v) => v as num),
          name: $checkedConvert('name', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$RepoProfileToJson(RepoProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'city': instance.city,
    };
