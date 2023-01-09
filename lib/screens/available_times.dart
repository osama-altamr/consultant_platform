import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/screens/homepage.dart';
import 'package:tutorial_app/screens/perosnal_info-second.dart';

import '../providers/language.dart';
import '../providers/personal-info.dart';
import '../widgets/custom_row_days.dart';

class AvailableTimeForExpert extends StatelessWidget {
  const AvailableTimeForExpert({super.key});
  static const routeName = '/available_time';

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
            body: Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available days',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courgette',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        SizedBox(
                          width: 90,
                        ),
                        Text(
                          'Start Time',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text('End Time', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  CustomRowAvailableTimes(
                    startTimeday: infoProvider.availableDays['Sunday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Sunday']['endTime'],
                    valueDay: infoProvider.availableDays['Sunday']
                        ['switchbool'],
                    day: "Sunday",
                  ),
                  CustomRowAvailableTimes(
                    day: "Monday",
                    startTimeday: infoProvider.availableDays['Monday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Monday']['endTime'],
                    valueDay: infoProvider.availableDays['Monday']
                        ['switchbool'],
                  ),
                  CustomRowAvailableTimes(
                    day: "Tuesday",
                    startTimeday: infoProvider.availableDays['Tuesday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Tuesday']
                        ['endTime'],
                    valueDay: infoProvider.availableDays['Tuesday']
                        ['switchbool'],
                  ),
                  CustomRowAvailableTimes(
                    day: "Wednesday",
                    startTimeday: infoProvider.availableDays['Wednesday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Wednesday']
                        ['endTime'],
                    valueDay: infoProvider.availableDays['Wednesday']
                        ['switchbool'],
                  ),
                  CustomRowAvailableTimes(
                    day: "Thursday",
                    startTimeday: infoProvider.availableDays['Thursday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Thursday']
                        ['endTime'],
                    valueDay: infoProvider.availableDays['Thursday']
                        ['switchbool'],
                  ),
                  CustomRowAvailableTimes(
                    day: "Friday",
                    startTimeday: infoProvider.availableDays['Friday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Friday']['endTime'],
                    valueDay: infoProvider.availableDays['Friday']
                        ['switchbool'],
                  ),
                  CustomRowAvailableTimes(
                    day: "Saturday",
                    startTimeday: infoProvider.availableDays['Saturday']
                        ['startTime'],
                    endTimeday: infoProvider.availableDays['Saturday']
                        ['endTime'],
                    valueDay: infoProvider.availableDays['Saturday']
                        ['switchbool'],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 60, bottom: 8),
                      child: Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.amber),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                    horizontal: 110,
                                    vertical: 10,
                                  ))),
                              onPressed: () async {
                                for (int i = 0; i < 7; i++) {
                                  print(infoProvider.availableDays);
                                }
                                await Provider.of<InformationProvider>(context,
                                        listen: false)
                                    .sendAllInformations()
                                    .then((_) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      HomePage.routeName, (route) => false);
                                });
                              },
                              child: Provider.of<Auth>(context).isLoading
                                  ? Center(
                                      child: LoadingAnimationWidget
                                          .staggeredDotsWave(
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    )
                                  : const Center(
                                      child: Text(
                                        'Get Started Now',
                                        style: TextStyle(
                                            fontFamily: 'Courgette',
                                            color: Colors.black),
                                      ),
                                    )))),
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
                        color: Colors.amber,
                      )),
                    ],
                    stepperDirection: Axis.horizontal,
                    inverted: true,
                    activeBarColor: Colors.amber,
                    inActiveBarColor: Colors.grey,
                    activeIndex: 3,
                    gap: 50,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
