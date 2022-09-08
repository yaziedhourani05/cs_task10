import 'package:fitness_app_riverpod/app/auth/onboarding/onboarding_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/registration_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:fitness_app_riverpod/app/workouts/wokrouts_tab.dart';
import 'package:fitness_app_riverpod/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final additionalInformationFormKeyProvider =
    StateProvider.autoDispose<GlobalKey<FormState>>(
  (ref) {
    return GlobalKey<FormState>();
  },
);

class AdditionalInformationForm extends HookConsumerWidget {
  AdditionalInformationForm({Key? key}) : super(key: key);
  final dobTextEditingController = useState(TextEditingController());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.watch(additionalInformationFormKeyProvider),
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
                    labelText: 'Height',
                    validator: (value) {
                      if (value == '') {
                        return 'please enter height';
                      } else if (double.parse(value!) > 300) {
                        return 'please enter correct height';
                      } else if (double.parse(value) <= 0) {
                        return 'please enter correct height';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (height) {
                      ref
                          .read(userProvider.notifier)
                          .setHeight(double.parse(height));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    labelText: 'Weight',
                    validator: (value) {
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
                    onChanged: (weight) {
                      ref
                          .read(userProvider.notifier)
                          .setWeight(double.parse(weight));
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: dobTextEditingController.value,
                    onTap: () async {
                      DateTime? pickerResult = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1920),
                        lastDate: DateTime(2100),
                      );
                      if (pickerResult != null) {
                        ref.read(userProvider.notifier).setDob(pickerResult);

                        dobTextEditingController.value.text =
                            pickerResult.toString();
                      }
                    },
                    validator: (value) {
                      if (value == '') {
                        return 'please enter date';
                      } else {
                        return null;
                      }
                    },
                    readOnly: true,
                    labelText: 'Date of Birth',
                    customWidth: 10,
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
                onPressed: () {
                  ref.watch(pageViewControllerProvider).previousPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                },
              ),
              CustomElevatedButton(
                label: 'next',
                onPressed: () {
                  ref.watch(_isLoadingProvider.state).state = true;
                  bool isValid = ref
                      .watch(additionalInformationFormKeyProvider)
                      .currentState!
                      .validate();
                  if (isValid) {
                    ref
                        .watch(additionalInformationFormKeyProvider)
                        .currentState!
                        .save();
                    ref.watch(pageViewControllerProvider).nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeIn,
                        );
                    UserService.createUser(ref.read(userProvider));
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
                  ref.watch(_isLoadingProvider.state).state = false;
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ref.watch(_isLoadingProvider)
                  ? Row(
                      children: const [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
    );
  }
}
