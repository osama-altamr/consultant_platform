import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/screens/homepage.dart';
import 'package:tutorial_app/screens/sign-up-user.dart';

import 'package:tutorial_app/widgets/textformfield.dart';
import 'package:tutorial_app/widgets/transfrom-icon.dart';

import '../providers/language.dart';

class SignInUserScreen extends StatefulWidget {
  const SignInUserScreen({super.key});
  static const routeName = '/signin-user';
  @override
  State<SignInUserScreen> createState() => _SignInUState();
}

GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
Map<String, String> authDataForm = {
  "email": '',
  "password": '',
};

bool isVisible = true;

class _SignInUState extends State<SignInUserScreen> {
  @override
  Widget build(BuildContext context) {
    var providerLang = Provider.of<LanguageProvider>(context);
    bool isLoading = Provider.of<Auth>(context).isLoading;
    return Directionality(
      textDirection:
          providerLang.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.only(
                  left: 12, top: 100, right: 12, bottom: 12),
              child: Column(
                children: [
                  Text(
                    providerLang.getText('welcome_back'),
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: !providerLang.isEnglish ? 55 : 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courgette',
                        shadows: const [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.white,
                              offset: Offset(2, 2)),
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.grey,
                              offset: Offset(2, 2)),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Text(
                      providerLang.getText('subtitle'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: !providerLang.isEnglish ? 20 : 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Form(
                        key: _globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 8, top: 8),
                              child: Text(
                                providerLang.getText('email_signup'),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.amber,
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
                                  left: 8.0, bottom: 8, top: 8),
                              child: Text(
                                providerLang.getText('password_signup'),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              cursorColor: Colors.white,
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
                                          ? const Icon(
                                              Icons.visibility,
                                              color: Colors.white,
                                            )
                                          : const Icon(
                                              Icons.visibility_off,
                                              color: Colors.white,
                                            ))),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 8) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (val) {
                                authDataForm['password'] = val!;
                              },
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      providerLang.getText(
                                        'forgot_pass',
                                      ),
                                      style: TextStyle(color: Colors.amber),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
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
                                onPressed: () => _loginSumpit(),
                                child: isLoading
                                    ? Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                          color: Colors.white,
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
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                SignUpUserScreen.routeName);
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
                  ),
                ],
              )),
        ),
      ),
    );
  }

  _loginSumpit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.save();
      Provider.of<Auth>(context, listen: false).changeIsLoading(true);

      try {
        await Provider.of<Auth>(context, listen: false)
            .loginUser(authDataForm)
            .then((value) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
          Provider.of<Auth>(context, listen: false).changeIsLoading(false);
        });
      } catch (error) {
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
      }
    }
  }
}
