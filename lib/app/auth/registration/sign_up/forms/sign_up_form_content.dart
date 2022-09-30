import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/sign_up/pages/sign_up_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpFormContent extends HookConsumerWidget {
  const SignUpFormContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  labelText: 'Email',
                  onSaved: (email) {
                    //save email from user input
                    ref.read(authUserProvider.notifier).setEmail(email!);
                  },
                  validator: (value) {
                    //validate email
                    bool emailIsValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (emailIsValid == false) {
                      return 'enter valid email';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      labelText: 'Password',
                      obsecureText: true,
                      onChanged: (password) {
                        //save password from user input
                        if (password != null) {
                          ref
                              .watch(authUserProvider.notifier)
                              .setPassword(password);
                        }
                      },
                      validator: (value) {
                        //validate password
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
                      obsecureText: true,
                      onChanged: (password) {
                        //check that password confirmation matches password
                        ref.watch(signUpFormKey).currentState!.validate();
                      },
                      validator: (value) {
                        //validate password confirmation
                        if (value == '') {
                          return 'please enter password';
                        } else if (value !=
                            ref.watch(authUserProvider).password) {
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
          ],
        ),
        //display loading when loading state is true
        ref.watch(signUpLoadingProvider)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                  Text('Loading')
                ],
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              label: 'register',
              //disable button when laoding
              onPressed: ref.watch(signUpLoadingProvider)
                  ? null
                  : () async {
                      //change laoding state to true
                      ref.watch(signUpLoadingProvider.notifier).state = true;
                      try {
                        //check if user input is valid
                        bool isValid =
                            ref.watch(signUpFormKey).currentState!.validate();
                        if (isValid) {
                          //if valid:
                          // 1. create user in data base
                          // 2. pop to base page
                          ref.watch(signUpFormKey).currentState!.save();
                          await UserService.createUser(
                              ref.read(authUserProvider));
                          // ignore: use_build_context_synchronously
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                        }
                      } on Exception catch (e) {
                        //show error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      } catch (e) {
                        //show error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                          ),
                        );
                      } finally {
                        //set loading state to true
                        ref.watch(signUpLoadingProvider.notifier).state = false;
                      }
                    },
            ),
          ],
        ),
        CustomElevatedButton(
          label: 'back',
          //disable when laoding
          onPressed: ref.watch(signUpLoadingProvider)
              ? null
              : () {
                  //cancel login
                  Navigator.pop(context);
                },
        ),
      ],
    );
  }
}
