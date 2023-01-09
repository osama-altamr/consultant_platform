import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/personal-info.dart';
import 'package:tutorial_app/screens/available_times.dart';
import 'package:tutorial_app/screens/homepage.dart';

import '../providers/language.dart';
import '../widgets/flustbar.dart';
import '../widgets/textformfield.dart';

class PersonalInformationExpertSecondScreen extends StatefulWidget {
  static const routeName = '/personal-info-second';
  const PersonalInformationExpertSecondScreen({super.key});

  @override
  State<PersonalInformationExpertSecondScreen> createState() =>
      _PersonalInformationExpertSecondScreenState();
}

class _PersonalInformationExpertSecondScreenState
    extends State<PersonalInformationExpertSecondScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? country;
  String? state;
  String? city;

  DateTime? _selectedDate = DateTime(2000);
  @override
  Widget build(BuildContext context) {
    var infoProvider = Provider.of<InformationProvider>(context);
    var providerLang = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection:
            providerLang.isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 10, right: 12),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      mini: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.amber,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.only(
                        left: 14,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${DateFormat.yMd().format(_selectedDate!)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: 'Arvo',
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                await dateOfBirth();
                              },
                              icon: const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Your Address',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CSCPicker(
                        showCities: true,
                        showStates: true,
                        dropdownItemStyle: TextStyle(color: Colors.black),
                        
                        onCountryChanged: (String? val) {
                          country = val;
                        },
                        onStateChanged: (String? val) {
                          state = val;
                        },
                        onCityChanged: (val) {
                          city = val;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Your Phone',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IntlPhoneField(
                      cursorColor: Colors.grey,
                      
                      style: TextStyle(color: Colors.grey),
                      decoration: CustomInputDecoration('', null),
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        infoProvider.allInformations['phoneNumber'] =
                            phone.completeNumber;
                        print(infoProvider.allInformations['phoneNumber']);
                      },
                    ),
                    const SizedBox(
                      height: 130,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.amber),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                            horizontal: 120,
                            vertical: 8,
                          ))),
                          onPressed: () {
                            if (city == null ||
                                state == null ||
                                country!.isEmpty) {
                              return CustomFlushBar('Please!',
                                  'All information are required', context);
                            } else {
                              infoProvider.allInformations['dateOfbirth'] =
                                  _selectedDate!.toIso8601String();
                              infoProvider.allInformations['address'] =
                                  '$country|$state|$city';
                              print(
                                  'info provider address ${infoProvider.allInformations['address'].toString().split('|')[0]}');
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  AvailableTimeForExpert.routeName,
                                  (route) => false);
                            }
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontFamily: 'Courgette', color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    AnotherStepper(
                      stepperList: [
                        StepperData(
                            iconWidget: const Icon(
                          Icons.radio_button_checked,
                          color: Colors.amber,
                        )),
                        StepperData(
                            iconWidget: const Icon(
                          Icons.radio_button_checked,
                          color: Colors.amber,
                        )),
                        StepperData(
                            iconWidget: const Icon(
                          Icons.radio_button_checked,
                          color: Colors.grey,
                        )),
                      ],
                      stepperDirection: Axis.horizontal,
                      inverted: true,
                      activeBarColor: Colors.amber,
                      inActiveBarColor: Colors.grey,
                      activeIndex: 2,
                      gap: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  dateOfBirth() async {
    await showDatePicker(
            initialEntryMode: DatePickerEntryMode.input,
            context: context,
            initialDate: _selectedDate!,
            firstDate: DateTime(1970),
            lastDate: DateTime(2015))
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() => _selectedDate = pickedDate);
        print(_selectedDate.toString());
        print(pickedDate.toString());
      } else {
        print('It\'s null or something is wrong');
      }
    });
  }
}
