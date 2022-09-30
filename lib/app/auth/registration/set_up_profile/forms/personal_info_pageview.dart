import 'package:fitness_app_riverpod/app/auth/providers/user_provider.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/forms/fitness_info_pageview.dart';
import 'package:fitness_app_riverpod/app/auth/registration/set_up_profile/pages/set_up_profile_page.dart';
import 'package:fitness_app_riverpod/app/auth/registration/sign_up/forms/sign_up_form_content.dart';
import 'package:fitness_app_riverpod/app/auth/registration/summery/summery_page.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_elevated_button.dart';
import 'package:fitness_app_riverpod/app/shared/widgets/custom_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalInfoPageView extends HookConsumerWidget {
  const PersonalInfoPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authUserProvider);

    final countryStateSelectedValue = useState('State');
    final dateOfBirthController = useState(
      TextEditingController(text: authUser.dob.toString()),
    );

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextField(
                labelText: 'First Name',
                maxLength: 15,
                onSaved: (value) {
                  //save firtname from user input
                  //check if null first
                  if (value != null) {
                    ref
                        .read(authUserProvider.notifier)
                        .setFirstName(value.trim());
                  }
                },
                validator: (value) {
                  //validate firtname
                  if (value == '' && value!.length < 3) {
                    print('please enter correct first name');
                    return 'please enter correct first name';
                  } else if (value!.length < 3) {
                    return 'please enter correct first name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  labelText: 'Last Name',
                  maxLength: 15,
                  validator: (value) {
                    //validate firtname
                    if (value == '') {
                      print('please enter correct first name');
                      return 'please enter correct first name';
                    } else if (value!.length < 3) {
                      return 'please enter correct first name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //save firtname from user input
                    //check if null first
                    if (value != null) {
                      ref
                          .read(authUserProvider.notifier)
                          .setLastName(value.trim());
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
              child: CustomTextField(
                controller: dateOfBirthController.value,
                onTap: () async {
                  //show date picker on tap
                  //get result
                  DateTime? pickerResult = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1920),
                    lastDate: DateTime(2100),
                  );

                  if (pickerResult != null) {
                    //check if pciker result is not null
                    //convert picker result to date only

                    final String dateOnly =
                        DateFormat('yyyy-MM-dd').format(pickerResult);
                    //save result
                    ref.read(authUserProvider.notifier).setDob(dateOnly);

                    dateOfBirthController.value.text = dateOnly.toString();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomTextField(
                labelText: 'Address',
                onSaved: (value) {
                  //save address from user input after checking not null
                  if (value != null) {
                    ref.read(authUserProvider.notifier).setAddress(
                          value.trim(),
                        );
                  }
                },
                validator: (value) {
                  //validate address input
                  if (value == '') {
                    return 'please enter address';
                  } else if (value == null) {
                    return 'please enter address';
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: Text(countryStateSelectedValue.value),
                  items: <String>['WA', 'QLD', 'NT', 'SA', 'Tas', 'Vic']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        //save user input
                        ref
                            .read(authUserProvider.notifier)
                            .setCountryState(value);
                        countryStateSelectedValue.value = value;
                      },
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  labelText: 'post code',
                  maxLength: 4,
                  onSaved: (value) {
                    //save post code from user input
                    if (value != null) {
                      ref.read(authUserProvider.notifier).setPostCode(
                            int.parse(
                              value.trim(),
                            ),
                          );
                    }
                  },
                  validator: (value) {
                    //validate inputted postcode.

                    if (value == '') {
                      return 'please enter postcode';
                    } else if (value == null) {
                      return 'please enter postCode';
                    } else if (value.length < 4) {
                      return 'please enter correct postCode';
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
                  labelText: 'School Name',
                  onSaved: (value) {
                    //save school name from user input after null check
                    if (value != null) {
                      ref.read(authUserProvider.notifier).setSchool(
                            value.trim(),
                          );
                    }
                  },
                  validator: (value) {
                    //validate user input
                    if (value == '') {
                      return 'please enter school name';
                    } else if (value == null) {
                      return 'please enter school name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        CustomElevatedButton(
          label: 'Next',
          //button disabled on loading
          onPressed: ref.watch(setUpLoadingProvider.notifier).state
              ? null
              : () async {
                  try {
                    // change loading status to true
                    ref.read(setUpLoadingProvider.notifier).state = true;
                    final formKey = ref.read(personalInfoFormKey);

                    //check if user input is valid and country state drop down value selected

                    bool textFieldsValid = formKey.currentState!.validate();
                    bool stateDropDownValid =
                        ref.read(authUserProvider).countryState != '';
                    if (textFieldsValid && stateDropDownValid) {
                      //save input if valid for later submission
                      formKey.currentState!.save();
                      ref.read(setUpPageViewControllerProvider).nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn,
                          );
                    } else if (stateDropDownValid == false) {
                      //error message if country state not selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('please select state'),
                        ),
                      );
                    }
                  } on Exception catch (e) {
                    //return error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  } catch (e) {
                    //return error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  } finally {
                    //change loading stat to false
                    ref.read(setUpLoadingProvider.notifier).state = false;
                  }
                },
        ),
      ],
    );
  }
}
