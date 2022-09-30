import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/forms/personal_info_pageview.dart';

import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/sign_up/forms/sign_up_form_content.dart';
import 'package:fitness_app_riverpod/app/auth/registration/summery/summery_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/app/workouts/pages/workouts_page.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class FitnessInfoPageView extends HookConsumerWidget {
  const FitnessInfoPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserInfo = ref.watch(currentUserInfoProvider);
    return currentUserInfo.when(
      error: (_, __) {
        return const Text('error occured');
      },
      loading: () {
        return Center(child: const CircularProgressIndicator());
      },
      data: (data) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      labelText: 'Height(Cm)',
                      maxLength: 7,
                      keyboardType: TextInputType.number,
                      initialValue: data.height.toString(),
                      onSaved: (value) {
                        //save height from user input
                        if (value != null) {
                          ref
                              .read(authUserProvider.notifier)
                              .setHeight(double.parse(value.trim()));
                        }
                      },
                      validator: (value) {
                        //validate user input
                        if (value == '') {
                          return 'please enter height';
                        } else if (double.parse(value!) > 300) {
                          return 'please enter correct height: <600';
                        } else if (double.parse(value) <= 0) {
                          return 'please enter correct height >';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      labelText: 'Weight(Kg)',
                      maxLength: 7,
                      initialValue: data.weight.toString(),
                      onSaved: (value) {
                        // save weight from user input
                        if (value != null) {
                          ref
                              .read(authUserProvider.notifier)
                              .setWeight(double.parse(value.trim()));
                        }
                      },
                      validator: (value) {
                        //validate user input
                        if (value == '') {
                          return 'please enter weight';
                        } else if (double.parse(value!) > 300) {
                          return 'please enter correct weight';
                        } else if (double.parse(value) <= 0) {
                          return 'please enter correct weight';
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
                      labelText: 'exercise days per week',
                      maxLength: 1,
                      initialValue: data.numberOfExerciseDays.toString(),
                      onSaved: (value) {
                        //save exerdays from user input
                        if (value != null) {
                          ref
                              .read(authUserProvider.notifier)
                              .setNumberOfExerciseDays(
                                int.parse(value.trim()),
                              );
                        }
                      },
                      validator: (value) {
                        //validate user input
                        if (value == '') {
                          return 'please complete text field';
                        } else if (value == null) {
                          return 'please complete text field';
                        } else if (int.parse(value) > 7) {
                          return 'please enter correct number';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            //show if laoding state is true
            ref.watch(setUpLoadingProvider)
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
                Expanded(
                  child: CustomElevatedButton(
                    label: 'Submit',
                    //button disabled if loading state true
                    onPressed: ref.watch(setUpLoadingProvider.notifier).state
                        ? null
                        : () async {
                            try {
                              //set loading state to true
                              ref.watch(setUpLoadingProvider.notifier).state =
                                  true;
                              //validate user input
                              bool isValid = ref
                                  .watch(fitnessInfoFormKey)
                                  .currentState!
                                  .validate();
                              if (isValid) {
                                //if user input valid:
                                // 1. save input.
                                // 2. save the profile set up is complete in database
                                // 3. upsert user information
                                // 4. display summery page
                                ref
                                    .watch(fitnessInfoFormKey)
                                    .currentState!
                                    .save();
                                ref
                                    .read(authUserProvider.notifier)
                                    .setProfileIsSetUp(true);
                                await UserService.upsertProfileInfo(
                                  ref.read(authUserProvider),
                                  UserService.currentUserId().uid,
                                );
                                //refreashes to brand new user data to be displayed
                                // in summery page
                                ref.refresh(currentUserInfoProvider);

                                ref.read(authUserProvider.notifier).dispose();

                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ProfileSummeryPage();
                                    },
                                  ),
                                );
                              }
                            } on Exception catch (e) {
                              //show error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            } catch (e) {
                              //show error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            } finally {
                              // change loading state to false
                              ref.watch(setUpLoadingProvider.notifier).state =
                                  false;
                            }
                          },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
