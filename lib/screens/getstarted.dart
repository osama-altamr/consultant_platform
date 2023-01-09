import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/language.dart';
import 'package:tutorial_app/screens/sign-up-expert.dart';
import 'package:tutorial_app/screens/sign-up-user.dart';

class GetStartedScreen extends StatefulWidget {
  GetStartedScreen({super.key});
  static const routeName = '/getstarted-screen';

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int tagOption = 0;
  int tagLanguage = 1;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    List<String> options = [
      provider.getText('text_expert'),
      provider.getText('text_user'),
    ];
    List<String> language = [
      provider.getText('arabic_text'),
      provider.getText('english_text'),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          margin: EdgeInsets.only(top: 120),
          child: Column(
            children: [
              const Text(
                '',
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Anton',
                  color: Colors.amber,
                ),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  child: Image.asset(
                      'assets/images/Starting a business project-amico.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, left: 8),
                child: Text(
                  provider.getText('started_account_type'),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 12,
                ),
                width: double.infinity,
                height: 60,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Transform.scale(
                    scale: 1.1,
                    child: ChipsChoice<int>.single(
                      value: tagOption,
                      onChanged: (val) => setState(() {
                        tagOption = val;
                      }),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: options,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      choiceCheckmark: true,
                      choiceStyle: const C2ChipStyle(
                        foregroundOpacity: 1,
                        checkmarkColor: Colors.amber,
                        checkmarkWeight: 2,
                        backgroundColor: Colors.grey,
                        backgroundAlpha: 200,
                      ),
                    ),
                  )
                ]),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                provider.getText('language_text'),
                style: TextStyle(color: Colors.white),
              ),
              Container(
                margin: EdgeInsets.only(left: 12),
                width: double.infinity,
                height: 90,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Transform.scale(
                    scale: 1.1,
                    child: ChipsChoice<int>.single(
                      value: tagLanguage,
                      onChanged: (val) => setState(() {
                        tagLanguage = val;
                        if (tagLanguage == 0) {
                          provider.changeLanguage(false);
                        } else {
                          provider.changeLanguage(true);
                        }
                      }),
                      choiceItems: C2Choice.listFrom<int, String>(
                        source: language,
                        value: (i, v) => i,
                        label: (i, v) => v,
                      ),
                      choiceCheckmark: true,
                      choiceStyle: const C2ChipStyle(
                        //   foregroundOpacity: 1,
                        foregroundOpacity: 1,
                        checkmarkColor: Colors.amber,
                        checkmarkWeight: 2,
                        backgroundColor: Colors.grey,
                        backgroundAlpha: 200,
                      ),
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        horizontal: 100,
                      ))),
                  onPressed: () {
                    if (tagOption == 0) {
                      Navigator.of(context)
                          .pushNamed(SignUpExpertScreen.routeName);
                    } else {
                      Navigator.of(context)
                          .pushNamed(SignUpUserScreen.routeName);
                    }
                  },
                  child: Text(
                    provider.getText('start'),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
  }

//   FilterChipCustom(String text, bool expert) {
//     return FilterChip.(
//       elevation: 1,
//       labelPadding: EdgeInsets.only(left: 10, right: 10),
//       shadowColor: Colors.redAccent,
//       label: Text(
//         text,
//         style: TextStyle(color: Colors.white),
//       ),
//       padding: EdgeInsets.all(10),
//       selected: isExpert==expert,
//       onSelected: (val) {
//         isExpert = val;
//       },
//       selectedColor: Colors.redAccent,
//     );
//   }
// }

}
