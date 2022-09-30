import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_riverpod/models/user/auth_user.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authUserProvider = StateNotifierProvider<AuthUserNotifier, AuthUser>(
  (ref) {
    return AuthUserNotifier();
  },
);

class AuthUserNotifier extends StateNotifier<AuthUser> {
  AuthUserNotifier()
      : super(
          const AuthUser(
            firstName: '',
            lastName: '',
            email: '',
            password: '',
            address: '',
            countryState: '',
            postCode: 0000,
            school: '',
            dob: '0000-00-00',
            weight: 0,
            height: 0,
            numberOfExerciseDays: 0,
            profileIsSetUp: false,
          ),
        );

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setDob(String dob) {
    state = state.copyWith(dob: dob);
  }

  setWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void setAddress(String address) {
    state = state.copyWith(address: address);
  }

  void setCountryState(String countryState) {
    state = state.copyWith(countryState: countryState);
  }

  void setPostCode(int postCode) {
    state = state.copyWith(postCode: postCode);
  }

  void setSchool(String school) {
    state = state.copyWith(school: school);
  }

  void setNumberOfExerciseDays(int numberOfDays) {
    state = state.copyWith(numberOfExerciseDays: numberOfDays);
  }

  void setProfileIsSetUp(bool profileIsSetUp) {
    state = state.copyWith(profileIsSetUp: profileIsSetUp);
  }
}
