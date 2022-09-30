// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'current_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return _CurrentUser.fromJson(json);
}

/// @nodoc
mixin _$CurrentUser {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  DateTime? get dob => throw _privateConstructorUsedError;
  double? get weight => throw _privateConstructorUsedError;
  double? get height => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentUserCopyWith<CurrentUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentUserCopyWith<$Res> {
  factory $CurrentUserCopyWith(
          CurrentUser value, $Res Function(CurrentUser) then) =
      _$CurrentUserCopyWithImpl<$Res>;
  $Res call(
      {String? firstName,
      String? lastName,
      String? email,
      String? password,
      String? gender,
      DateTime? dob,
      double? weight,
      double? height});
}

/// @nodoc
class _$CurrentUserCopyWithImpl<$Res> implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._value, this._then);

  final CurrentUser _value;
  // ignore: unused_field
  final $Res Function(CurrentUser) _then;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? weight = freezed,
    Object? height = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: dob == freezed
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$$_CurrentUserCopyWith<$Res>
    implements $CurrentUserCopyWith<$Res> {
  factory _$$_CurrentUserCopyWith(
          _$_CurrentUser value, $Res Function(_$_CurrentUser) then) =
      __$$_CurrentUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? firstName,
      String? lastName,
      String? email,
      String? password,
      String? gender,
      DateTime? dob,
      double? weight,
      double? height});
}

/// @nodoc
class __$$_CurrentUserCopyWithImpl<$Res> extends _$CurrentUserCopyWithImpl<$Res>
    implements _$$_CurrentUserCopyWith<$Res> {
  __$$_CurrentUserCopyWithImpl(
      _$_CurrentUser _value, $Res Function(_$_CurrentUser) _then)
      : super(_value, (v) => _then(v as _$_CurrentUser));

  @override
  _$_CurrentUser get _value => super._value as _$_CurrentUser;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? gender = freezed,
    Object? dob = freezed,
    Object? weight = freezed,
    Object? height = freezed,
  }) {
    return _then(_$_CurrentUser(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: dob == freezed
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrentUser implements _CurrentUser {
  _$_CurrentUser(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.gender = 'none',
      this.dob,
      this.weight,
      this.height});

  factory _$_CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$$_CurrentUserFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? password;
  @override
  @JsonKey()
  final String? gender;
  @override
  final DateTime? dob;
  @override
  final double? weight;
  @override
  final double? height;

  @override
  String toString() {
    return 'CurrentUser(firstName: $firstName, lastName: $lastName, email: $email, password: $password, gender: $gender, dob: $dob, weight: $weight, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentUser &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.gender, gender) &&
            const DeepCollectionEquality().equals(other.dob, dob) &&
            const DeepCollectionEquality().equals(other.weight, weight) &&
            const DeepCollectionEquality().equals(other.height, height));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(gender),
      const DeepCollectionEquality().hash(dob),
      const DeepCollectionEquality().hash(weight),
      const DeepCollectionEquality().hash(height));

  @JsonKey(ignore: true)
  @override
  _$$_CurrentUserCopyWith<_$_CurrentUser> get copyWith =>
      __$$_CurrentUserCopyWithImpl<_$_CurrentUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrentUserToJson(
      this,
    );
  }
}

abstract class _CurrentUser implements CurrentUser {
  factory _CurrentUser(
      {final String? firstName,
      final String? lastName,
      final String? email,
      final String? password,
      final String? gender,
      final DateTime? dob,
      final double? weight,
      final double? height}) = _$_CurrentUser;

  factory _CurrentUser.fromJson(Map<String, dynamic> json) =
      _$_CurrentUser.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get gender;
  @override
  DateTime? get dob;
  @override
  double? get weight;
  @override
  double? get height;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentUserCopyWith<_$_CurrentUser> get copyWith =>
      throw _privateConstructorUsedError;
}
