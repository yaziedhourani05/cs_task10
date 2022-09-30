import 'package:fitness_app_riverpod/app/auth/registration/additional_info_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/name_form.dart';
import 'package:fitness_app_riverpod/app/auth/registration/password_form.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/models/current_user.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final pageViewControllerProvider = StateProvider.autoDispose<PageController>(
  (ref) {
    return PageController();
  },
);

class RegistrationPage extends HookConsumerWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: Scaffold(
        body: Column(
          children: [
            const Expanded(child: CustomHeader(title: 'set up your profile')),
            Expanded(
              flex: 10,
              child: Stack(
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: ref.watch(pageViewControllerProvider),
                    children: [
                      const NameForm(),
                      const PasswordForm(),
                      AdditionalInformationForm(),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SmoothPageIndicator(
                      controller: ref.watch(pageViewControllerProvider),
                      count: 3,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
