import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';

import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/summery/summery_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/main.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkoutsPage extends HookConsumerWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('workouts_page.dart'),
              CustomElevatedButton(
                label: 'log out',
                onPressed: () {
                  return UserService.logout();
                },
              ),
              CustomElevatedButton(
                label: 'profile summary',
                onPressed: () {
                  ref.watch(fromWorkoutsPage.notifier).state = true;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ProfileSummeryPage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
