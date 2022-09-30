import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_user.freezed.dart';
part 'current_user.g.dart';

@Freezed()
class CurrentUser with _$CurrentUser {
  factory CurrentUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    @Default('none') String? gender,
    DateTime? dob,
    double? weight,
    double? height,
  }) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
}
