import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/app/workouts/pages/workouts_page.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final formKeyProvider = StateProvider<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
  },
);

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        child: SafeArea(
      bottom: false,
      child: Scaffold(
        body: Form(
          key: ref.watch(formKeyProvider),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                child: CustomHeader(
                  title: 'Login',
                  enableLeading: true,
                ),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'email',
                            onChanged: (value) {
                              //save email from user input
                              if (value != null) {
                                ref
                                    .watch(authUserProvider.notifier)
                                    .setEmail(value.trim());
                              }
                            },
                            validator: (value) {
                              //validate on submit
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'password',
                            obsecureText: true,
                            onChanged: (value) {
                              //save password from user input
                              if (value != null) {
                                ref
                                    .watch(authUserProvider.notifier)
                                    .setPassword(value.trim());
                              }
                            },
                            validator: (value) {
                              //validate on submit
                              if (value == '') {
                                print('please enter correct password');
                                return 'please enter correct password';
                              } else if (value!.length < 7) {
                                return 'please enter correct password';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ref.watch(isLoadingProvider) == true
                            ? Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  Text('loading'),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          label: 'Login',
                          //Disable login button when loading
                          onPressed: ref.watch(isLoadingProvider)
                              ? null
                              : () async {
                                  // change loading state to true
                                  ref.watch(isLoadingProvider.state).state =
                                      true;

                                  try {
                                    //try to login
                                    //validate if user input is correct
                                    if (ref
                                        .watch(formKeyProvider)
                                        .currentState!
                                        .validate()) {
                                      //login if user input is valid and requirements met
                                      await UserService.login(
                                          ref.read(authUserProvider));
                                      //pop to previous page
                                      // ignore: use_build_context_synchronously
                                      Navigator.popUntil(
                                        context,
                                        (route) => route.isFirst,
                                      );
                                    }
                                    // set laoding state to false
                                  } on Exception catch (e) {
                                    //catch and display error
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  } catch (e) {
                                    //catch and display error
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  } finally {
                                    ref.watch(isLoadingProvider.state).state =
                                        false;
                                  }
                                },
                        ),
                        CustomElevatedButton(
                          label: 'back',
                          //disable when laoding
                          onPressed: ref.watch(isLoadingProvider)
                              ? null
                              : () {
                                  //cancel login
                                  Navigator.pop(context);
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
