import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/app/workouts/pages/workouts_page.dart';
import 'package:fitness_app_riverpod/models/user/auth_user.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentUserInfoProvider =
    FutureProvider.autoDispose<AuthUser>((ref) async {
  return UserService.getCurrentUserInfo();
  //retrieve user data from database
});

final summeryFormKey = StateProvider.autoDispose<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
    //form key
  },
);

final fromWorkoutsPage = StateProvider<bool>(
  (ref) => false,
  //check if user is viewing from workout page
);

final _summeryLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
  //loading state provider
});

class ProfileSummeryPage extends HookConsumerWidget {
  const ProfileSummeryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserInfoProvider).when(
      error: (_, __) {
        //error retrieving data
        return const Text('error occured');
      },
      loading: () {
        //loading data
        return const Center(child: CircularProgressIndicator());
      },
      data: (data) {
        //data retrieved
        return WillPopScope(
          onWillPop: () async {
            if (Navigator.of(context).userGestureInProgress) {
              return false;
            } else {
              return true;
            }
          },
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              //present data
              body: Column(
                children: [
                  const CustomHeader(
                      title: 'Profile Summery', enableLeading: true),
                  const CustomHeader(
                      title: 'personal Info', enableLeading: false),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('first name: '),
                            Text(data.firstName),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('email: '),
                            Text(data.email),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('last name: '),
                            Text(data.lastName),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Date of Birth: '),
                            Text(data.dob.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Address: '),
                            Text(data.address),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('School: '),
                            Text(data.school),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const CustomHeader(
                      title: 'fitness Info', enableLeading: false),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Height: '),
                            Text(data.height.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Weight: '),
                            Text(data.height.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Days of exercise per week : '),
                            Text(data.numberOfExerciseDays.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    label: 'done',
                    onPressed: () {
                      //checks if user is coming from workouts
                      if (ref.read(fromWorkoutsPage) == true) {
                        Navigator.pop(context);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const WorkoutsPage();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
