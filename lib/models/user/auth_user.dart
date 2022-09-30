import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

T? ignore<T>(dynamic _) => null;

@freezed
class AuthUser with _$AuthUser {
  @JsonSerializable(includeIfNull: false)
  const factory AuthUser({
    required String firstName,
    required String lastName,
    required String email,
    @JsonKey(toJson: ignore) String? password,
    required String address,
    required String countryState,
    required int postCode,
    required String school,
    required String dob,
    required double weight,
    required double height,
    required int numberOfExerciseDays,
    @Default(false) bool profileIsSetUp,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
