import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/providers/personal-info.dart';
import 'package:tutorial_app/screens/perosnal_info-second.dart';

import 'package:tutorial_app/widgets/textformfield.dart';

import '../providers/language.dart';

class PersonalInformationExpertScreen extends StatelessWidget {
  PersonalInformationExpertScreen({super.key});
  static const routeName = '/personal-info-first';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 3)))
      .toString();

  FilterOptionConsultation filterOptionConsultation =
      FilterOptionConsultation.medical;

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerLang = Provider.of<LanguageProvider>(context);

    var infoProvider = Provider.of<InformationProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection:
            providerLang.isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 45, left: 8, right: 8),
              child: Form(
                key: _globalKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Courgette',
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Type of Consultation',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 170),
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              infoProvider.allInformations['textConsultation'],
                              style: TextStyle(color: Colors.white),
                            ),
                            Spacer(),
                            PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                              color: Colors.black,
                              onSelected: (FilterOptionConsultation val) {
                                Provider.of<InformationProvider>(context,
                                        listen: false)
                                    .selectedTypeConsultation(val);
                              },
                              itemBuilder: (_) {
                                return const [
                                  PopupMenuItem(
                                    child: Text(
                                      'Medical',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    value: FilterOptionConsultation.medical,
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      'Professional',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    value:
                                        FilterOptionConsultation.professional,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Family',
                                        style: TextStyle(color: Colors.grey)),
                                    value: FilterOptionConsultation.family,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Psychological',
                                        style: TextStyle(color: Colors.grey)),
                                    value:
                                        FilterOptionConsultation.psychological,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Business',
                                        style: TextStyle(color: Colors.grey)),
                                    value: FilterOptionConsultation.business,
                                  ),
                                ];
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.amber,
                          key: Key('Years'),
                          keyboardType: TextInputType.number,
                          decoration: CustomInputDecoration(
                              'Years of experience ',
                              Icon(
                                Icons.emoji_events,
                                color: Colors.amber,
                              )),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'invalid number';
                            }
                            int? value = int.parse(val);
                            if (value > 30) {
                              return 'invalid number ';
                            }
                            if (value < 3) {
                              return "It requires more years of experience";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            infoProvider.allInformations['yearsofexperience'] =
                                val;
                          },
                        ),
                      ),
                      if (infoProvider.allInformations['textConsultation'] ==
                          'Medical')
                        const SizedBox(
                          height: 20,
                        ),
                      if (infoProvider.allInformations['textConsultation'] ==
                          'Medical')
                        TextFormField(
                          style: TextStyle(color: Colors.grey),
                          key: Key('Specialization'),
                          keyboardType: TextInputType.text,
                          readOnly: infoProvider
                                      .allInformations['textConsultation'] ==
                                  'Medical'
                              ? false
                              : true,
                          decoration: CustomInputDecoration(
                              'Specialization',
                              const Icon(
                                Icons.work_history,
                                color: Colors.amber,
                              )),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid-Specialization ';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            infoProvider.allInformations['specialization'] =
                                val!;
                          },
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.grey),
                        key: Key('Description'),
                        cursorColor: Colors.amber,
                        maxLines: 3,
                        decoration: CustomInputDecoration(
                            'Description',
                            const Icon(
                              Icons.description,
                              color: Colors.amber,
                            )),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "invalid-description";
                          }
                          if (val.length < 30) {
                            return "description can't to be less than 30 letter ";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          infoProvider.allInformations['description'] = val!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(left: 10),
                      //   child: Text(
                      //     'Available Days',
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.amber,
                          key: Key('Years'),
                          keyboardType: TextInputType.name,
                          decoration: CustomInputDecoration(
                              'Workplace',
                              Icon(
                                Icons.place,
                                color: Colors.amber,
                              )),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'invalid workplace';
                            }

                            if (val.length < 5) {
                              return 'invalid number ';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            infoProvider.allInformations['workplace'] = val;
                          },
                        ),
                      ),
                      // const Padding(
                      //   padding: const EdgeInsets.only(top: 12.0),
                      //   child: Text(
                      //     'Optional ',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 25,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 17),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey),
                          cursorColor: Colors.amber,
                          decoration: CustomInputDecoration(
                              'LinkedIn-link ',
                              const Icon(
                                CommunityMaterialIcons.linkedin,
                                color: Colors.amber,
                              )),
                          validator: (val) {
                            if (!val!.endsWith(".com") ||
                                !val.startsWith("https://")) {
                              return 'Invalid-link';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) {
                            infoProvider.allInformations['linkedinLink'] = val;
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 45,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                  horizontal: 120,
                                  vertical: 8,
                                ))),
                            onPressed: () {
                              if (!_globalKey.currentState!.validate()) {
                              } else {
                                _globalKey.currentState!.save();
                                logger.d(
                                    '${Provider.of<InformationProvider>(context, listen: false).allInformations}');
                                Navigator.of(context).pushNamed(
                                  PersonalInformationExpertSecondScreen
                                      .routeName,
                                  // arguments: {
                                  //   "textConsultation": textConsultation,
                                  //   "description": description,
                                  //   "workplace": workplace,
                                  //   "linkedin_link": linkedinLink,
                                  //   if (textConsultation == 'Medical')
                                  //     'specialization': specialization,
                                  // },
                                );
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
                              iconWidget: Icon(
                            Icons.radio_button_checked,
                            color: Colors.amber,
                          )),
                          StepperData(
                              iconWidget: Icon(
                            Icons.radio_button_checked,
                            color: Colors.grey,
                          )),
                          StepperData(
                              iconWidget: Icon(
                            Icons.radio_button_checked,
                            color: Colors.grey,
                          )),
                        ],
                        stepperDirection: Axis.horizontal,
                        inverted: true,
                        activeBarColor: Colors.amber,
                        inActiveBarColor: Color.fromARGB(255, 36, 32, 32),
                        activeIndex: 1,
                        gap: 50,
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum FilterOptionConsultation {
  medical,
  professional,
  family,
  psychological,
  business
}

/* 
Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SelectWeekDays(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          days: _days,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              colors: [
                                Color.fromARGB(255, 92, 154, 229),
                                Color.fromARGB(255, 251, 117, 117)
                              ],
                              tileMode: TileMode.repeated,
                            ),
                          ),
                          onSelect: (values) {
                            _availableDays = values;
                            print('values ${values}');
                            print('available ${_availableDays}');
                          },
                        ),
                      ),
                    ) */