import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/screens/homepage.dart';
import 'package:tutorial_app/screens/perosnal_info-first.dart';
import 'package:tutorial_app/screens/sign-up-expert.dart';

import '../providers/language.dart';
import '../widgets/textformfield.dart';
import '../widgets/transfrom-icon.dart';

class LoginExpert extends StatefulWidget {
  LoginExpert({super.key});
  static const routeName = '/login-expert';

  @override
  State<LoginExpert> createState() => _LoginExpertState();
}

class _LoginExpertState extends State<LoginExpert> {
  bool isVisible = true;

  Map<String, String> authDataForm = {
    "email": '',
    "password": '',
  };
  GlobalKey<FormState> _key = GlobalKey<FormState>(debugLabel: 'login-experet');
  @override
  Widget build(BuildContext context) {
    Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
    bool? fromSignUp = data!['fromSignup'];
    bool isLoading = Provider.of<Auth>(context).isLoading;
    var providerLang = Provider.of<LanguageProvider>(context);
    return SafeArea(
        child: Directionality(
      textDirection:
          providerLang.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            Container(
                height: 320,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/images/Privacy policy-rafiki.png',
                  ),
                )),
                width: double.infinity,
                child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 8, bottom: 5),
              child: Text(
                providerLang.getText('title_login_expert'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courgette',
                    shadows: [
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.amber,
                          offset: Offset(2, 2)),
                      BoxShadow(
                          blurRadius: 2,
                          color: Colors.black,
                          offset: Offset(2, 2)),
                    ]),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Text(
                          providerLang.getText('email_signup'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        cursorColor: Colors.amber,
                        style: TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.emailAddress,
                        decoration: CustomInputDecoration(
                            '',
                            const Icon(
                              CommunityMaterialIcons.facebook_workplace,
                              color: Colors.white,
                            )),
                        validator: (val) {
                          if (val!.isEmpty || !val.contains('@')) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          authDataForm['email'] = val!;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Text(
                          providerLang.getText('password_signup'),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        cursorColor: Colors.amber,
                        style: TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isVisible,
                        decoration: CustomInputDecoration(
                            '',
                            const Icon(
                              Icons.lock,
                              color: Colors.white,
                            )).copyWith(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible == true
                                    ? const Icon(Icons.visibility,
                                        color: Colors.amber)
                                    : const Icon(Icons.visibility_off,
                                        color: Colors.amber))),
                        validator: (val) {
                          if (val!.isEmpty || val.length < 8) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          authDataForm['password'] = val!;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              // minimumSize: MaterialStateProperty.all(Size(20, 20)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 40,
                                ),
                              ),
                            ),
                            onPressed: () {
                              _submitLogin(fromSignUp);
                            },
                            child: isLoading
                                ? Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                      color: Colors.black,
                                      size: 22,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                    providerLang.getText('signin'),
                                    style: TextStyle(color: Colors.black),
                                  )),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            CustomIconButton(
                              function: () {},
                              icon: CommunityMaterialIcons.google,
                              tag: 'google',
                              colorIcon: Colors.green,
                            ),
                            CustomIconButton(
                              function: () {},
                              icon: CommunityMaterialIcons.facebook,
                              tag: 'facebook',
                              colorIcon: Colors.blue,
                            ),
                            CustomIconButton(
                              function: () {},
                              icon: CommunityMaterialIcons.github,
                              tag: 'github',
                              colorIcon: Colors.grey,
                            ),
                            CustomIconButton(
                              function: () {},
                              icon: CommunityMaterialIcons.twitter,
                              tag: 'twitter',
                              colorIcon: Colors.lightBlue,
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              providerLang.getText('noaccont'),
                              style: TextStyle(color: Colors.white),
                            ),
                            Builder(builder: (ctx) {
                              return TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignUpExpertScreen.routeName);
                                },
                                child: Text(
                                  providerLang.getText('signup'),
                                  style: TextStyle(
                                    color: Colors.amber,
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ]),
        )),
      ),
    ));
  }

  _submitLogin(bool? fromSignUp) async {
    if (!_key.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _key.currentState!.save();
      Provider.of<Auth>(context, listen: false).changeIsLoading(true);
      await Provider.of<Auth>(context, listen: false)
          .loginExpert(authDataForm)
          .then((_) {
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
        if (fromSignUp == true) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              PersonalInformationExpertScreen.routeName, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        }
      }).catchError((e) {
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
      });
    }
  }
}
