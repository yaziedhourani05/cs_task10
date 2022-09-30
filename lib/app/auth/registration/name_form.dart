import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/registration_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final nameFormKeyProvider = StateProvider.autoDispose<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
  },
);

class NameForm extends HookConsumerWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.watch(nameFormKeyProvider),
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
                    labelText: 'First Name',
                    validator: (value) {
                      if (value == '' && value!.length < 3) {
                        print('please enter correct first name');
                        return 'please enter correct first name';
                      } else if (value!.length < 3) {
                        return 'please enter correct first name';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (firstName) {
                      ref.read(userProvider.notifier).setFirstName(firstName);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    labelText: 'Last Name',
                    validator: (value) {
                      if (value == '') {
                        print('please enter correct first name');
                        return 'please enter correct first name';
                      } else if (value!.length < 3) {
                        return 'please enter correct first name';
                      }
                      return null;
                    },
                    onChanged: (lastName) {
                      ref.read(userProvider.notifier).setLastName(lastName);
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
                    labelText: 'Email',
                    onChanged: (email) {
                      ref.read(userProvider.notifier).setEmail(email);
                    },
                    validator: (value) {
                      if (value == '') {
                        print('please enter correct email address');
                        return 'please enter correct email address';
                      } else if (value!.contains('@') == false) {
                        return 'please enter correct email';
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
                      curve: Curves.easeIn);
                },
              ),
              CustomElevatedButton(
                label: 'next',
                onPressed: () {
                  bool isValid =
                      ref.watch(nameFormKeyProvider).currentState!.validate();
                  if (isValid) {
                    ref.watch(nameFormKeyProvider).currentState!.save();
                    ref.watch(pageViewControllerProvider).nextPage(
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
