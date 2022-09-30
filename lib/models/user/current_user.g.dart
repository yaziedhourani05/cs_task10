// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CurrentUser _$$_CurrentUserFromJson(Map<String, dynamic> json) =>
    _$_CurrentUser(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String? ?? 'none',
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_CurrentUserToJson(_$_CurrentUser instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'dob': instance.dob?.toIso8601String(),
      'weight': instance.weight,
      'height': instance.height,
    };
