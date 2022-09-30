import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';
import 'package:fitness_app_riverpod/app/workouts/pages/workouts_page.dart';
import 'package:fitness_app_riverpod/firebase_options.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  return UserService.getAuthStateChanges();
});

final currentUserProvider =
    FutureProvider.family<dynamic, String>((ref, userId) async {
  return UserService.getCurrentUserInfo();
});

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ref.watch(authStateChangesProvider).when(
        data: (user) {
          //to check whether user is logged in
          if (user != null) {
            print(user.uid);
            return ref.watch(currentUserProvider(user.uid)).when(
                  data: (currentUser) {
                    //to check if user has set up a prodfile before accessing app
                    if (currentUser.profileIsSetUp == true) {
                      return const WorkoutsPage();
                    } else {
                      return const SetUpProfilePage();
                    }
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                    return const Text('error 1 occured');
                  },
                );
          } else {
            return OnboardingPage();
          }
        },
        error: (_, __) {
          return const Text('error occured');
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
