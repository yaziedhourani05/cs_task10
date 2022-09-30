import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/auth/registration/sign_up/forms/sign_up_form_content.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';

import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  //loading state provider
  return false;
});

final signUpFormKey = StateProvider.autoDispose<GlobalKey<FormState>>(
  //form key
  (ref) {
    return GlobalKey<FormState>();
  },
);

class SignUpPage extends HookConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Form(
          key: ref.watch(signUpFormKey),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: const [
                    CustomHeader(title: 'Registration', enableLeading: true),
                    //get content from file
                    SignUpFormContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
