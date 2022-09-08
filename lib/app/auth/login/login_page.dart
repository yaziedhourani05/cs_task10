import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/registration_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_header.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/app/workouts/wokrouts_tab.dart';
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
        child: Scaffold(
      body: Form(
        key: ref.watch(formKeyProvider),
        child: Column(
          children: [
            const Expanded(child: CustomHeader(title: 'Login')),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'email',
                            onChanged: (value) {
                              ref.watch(userProvider.notifier).setEmail(value);
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
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: 'password',
                            onChanged: (value) {
                              ref
                                  .watch(userProvider.notifier)
                                  .setPassword(value);
                            },
                            validator: (value) {
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        label: 'back',
                        onPressed: ref.watch(isLoadingProvider)
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                      ),
                      CustomElevatedButton(
                        label: 'next',
                        onPressed: ref.watch(isLoadingProvider)
                            ? null
                            : () async {
                                ref.watch(isLoadingProvider.state).state = true;

                                try {
                                  if (ref
                                      .watch(formKeyProvider)
                                      .currentState!
                                      .validate()) {
                                    await UserService.login(
                                        ref.read(userProvider));
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const WorkoutsPage();
                                        },
                                      ),
                                    );
                                  }
                                  ref.watch(isLoadingProvider.state).state =
                                      false;
                                } on Exception catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                                ref.watch(isLoadingProvider.state).state =
                                    false;
                              },
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
                                Text('loading please wait'),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
