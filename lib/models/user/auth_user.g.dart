// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthUser _$$_AuthUserFromJson(Map<String, dynamic> json) => _$_AuthUser(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      address: json['address'] as String,
      countryState: json['countryState'] as String,
      postCode: json['postCode'] as int,
      school: json['school'] as String,
      dob: json['dob'] as String,
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      numberOfExerciseDays: json['numberOfExerciseDays'] as int,
      profileIsSetUp: json['profileIsSetUp'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AuthUserToJson(_$_AuthUser instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('password', ignore(instance.password));
  val['address'] = instance.address;
  val['countryState'] = instance.countryState;
  val['postCode'] = instance.postCode;
  val['school'] = instance.school;
  val['dob'] = instance.dob;
  val['weight'] = instance.weight;
  val['height'] = instance.height;
  val['numberOfExerciseDays'] = instance.numberOfExerciseDays;
  val['profileIsSetUp'] = instance.profileIsSetUp;
  return val;
}
