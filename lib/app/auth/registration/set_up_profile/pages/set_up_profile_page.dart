import 'package:address_search_field/address_search_field.dart';
import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/forms/fitness_info_pageview.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/forms/personal_info_pageview.dart';

import 'package:fitness_app_riverpod/app/auth/registration/sign_up/forms/sign_up_form_content.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/app/workouts/pages/workouts_page.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final setUpPageViewControllerProvider = StateProvider<PageController>((ref) {
  return PageController();
  //pageview controller
});

final setUpLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
  //laoding state provider
});
final personalInfoFormKey = Provider<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
    //first page view form key
  },
);

final fitnessInfoFormKey = Provider<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
    //seocnd page view form key
  },
);

class SetUpProfilePage extends HookConsumerWidget {
  const SetUpProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final first = ref.watch(personalInfoFormKey);
    final second = ref.watch(fitnessInfoFormKey);
    //prevent slide to navigate on pageview
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
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                CustomHeader(
                  title: 'Set Up Profile',
                  enableLeading: false,
                  action: IconButton(
                    onPressed: () {
                      UserService.logout();
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: PageView(
                    controller: ref.watch(setUpPageViewControllerProvider),
                    children: [
                      //personal information form
                      Form(
                        key: first,
                        child: const PersonalInfoPageView(),
                      ),
                      //fitness information form
                      Form(
                        key: second,
                        child: const FitnessInfoPageView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
