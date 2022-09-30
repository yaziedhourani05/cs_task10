import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/registration_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordFormKeyProvider = StateProvider.autoDispose<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
  },
);

class PasswordForm extends HookConsumerWidget {
  const PasswordForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.watch(passwordFormKeyProvider),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    labelText: 'Password',
                    onChanged: (password) {
                      ref.watch(userProvider.notifier).setPassword(password);
                    },
                    validator: (value) {
                      if (value == '') {
                        return 'please enter password';
                      } else if (value == null) {
                        return 'please enter password';
                      } else if (value.length < 7) {
                        return 'please enter strong password';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    labelText: 'Confirm Password',
                    onChanged: (password) {},
                    validator: (value) {
                      if (value == '') {
                        return 'please enter password';
                      } else if (value != ref.watch(userProvider).password) {
                        return 'passwords do not match';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomElevatedButton(
                  label: 'back',
                  onPressed: () {
                    ref.watch(pageViewControllerProvider).previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                        );
                  }),
              CustomElevatedButton(
                label: 'next',
                onPressed: () {
                  bool isValid = ref
                      .watch(passwordFormKeyProvider)
                      .currentState!
                      .validate();

                  if (isValid) {
                    ref.watch(passwordFormKeyProvider).currentState!.save();
                    ref.read(pageViewControllerProvider).nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                        );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
