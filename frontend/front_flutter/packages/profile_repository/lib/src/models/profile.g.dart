// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Profile',
      json,
      ($checkedConvert) {
        final val = Profile(
          id: $checkedConvert('id', (v) => v as num),
          name: $checkedConvert('name', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'city': instance.city,
    };
