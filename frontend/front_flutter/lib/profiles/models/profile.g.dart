// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlocProfile _$BlocProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ProfileAidant',
      json,
      ($checkedConvert) {
        final val = BlocProfile(
          id: $checkedConvert('id', (v) => v as num),
          name: $checkedConvert('name', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$BlocProfileToJson(BlocProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'city': instance.city,
    };
