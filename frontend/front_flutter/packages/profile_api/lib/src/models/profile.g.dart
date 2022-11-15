// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiProfile _$ApiProfileFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Profile',
      json,
      ($checkedConvert) {
        final val = ApiProfile(
          id: $checkedConvert('id', (v) => v as num),
          name: $checkedConvert('name', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
        );
        return val;
      },
    );
