import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/providers/language.dart';
import 'package:tutorial_app/screens/login-expert.dart';
import 'package:tutorial_app/screens/login-user.dart';
import 'package:tutorial_app/screens/perosnal_info-first.dart';

import '../widgets/textformfield.dart';

class SignUpExpertScreen extends StatefulWidget {
  const SignUpExpertScreen({super.key});

  static const routeName = '/sign-up-expert';

  @override
  State<SignUpExpertScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpExpertScreen> {
  XFile? _xFile;
  ImagePicker _imagePicker = ImagePicker();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Map<String, String> authDataForm = {
    'email': '',
    'password': '',
    'username': '',
    'imageUrl': '',
  };

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<Auth>(context).isLoading;
    var providerLang = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection:
          providerLang.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 55, left: 4, right: 4),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  Container(
                    margin: const EdgeInsets.only(left: 8, top: 6, right: 8),
                    child: Text(providerLang.getText('title_signup_expert'),
                        style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Courgette',
                            shadows: [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.white,
                                  offset: Offset(2, 2)),
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.grey,
                                  offset: Offset(2, 2)),
                            ])),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    // fit: StackFit.expand,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade400,
                          backgroundImage: _xFile != null
                              ? FileImage(File(_xFile!.path))
                              : null,
                          child: _xFile != null
                              ? null
                              : const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 70,
                                ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 60,
                          top: 70,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              showDialogImage();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.amber,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 8,
                    ),
                    child: Form(
                        key: _globalKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              keyboardType: TextInputType.name,
                              decoration: CustomInputDecoration(
                                providerLang.getText('full_name_signup'),
                                const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                              ),
                              validator: (val) {
                                if (val!.length < 5 || val.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                authDataForm['username'] = val!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              keyboardType: TextInputType.emailAddress,
                              decoration: CustomInputDecoration(
                                providerLang.getText('email_signup'),
                                const Icon(
                                  CommunityMaterialIcons.facebook_workplace,
                                  color: Colors.white,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty || !val.contains('@')) {
                                  return '';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                authDataForm['email'] = val!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.grey),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: CustomInputDecoration(
                                providerLang.getText('password_signup'),
                                const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty || val.length < 6) {
                                  return '';
                                }
                                return null;
                              },
                              onSaved: (val) {
                                authDataForm['password'] = val!;
                              },
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.amber),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                      horizontal: 100,
                                    ))),
                                onPressed: () async {
                                  _signUpSupmit();
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
                                        providerLang.getText('signup'),
                                        style: TextStyle(color: Colors.black),
                                      )),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                    child: Text(
                                  providerLang.getText('if_haveaccount'),
                                  style: TextStyle(color: Colors.white),
                                )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LoginExpert.routeName,
                                              arguments: {
                                            "fromSignup": false,
                                          });
                                    },
                                    child: Text(
                                      providerLang.getText('signin'),
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.white),
                                    )),
                              ],
                            ),
                          ],
                        )),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  uploadImage(ImageSource imageSource) async {
    var pickedImage = await _imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        _xFile = XFile(pickedImage.path);
      });
    } else {
      print('Null Method picked image');
    }
  }

  showDialogImage() {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Please Choose Image'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () async {
                  await uploadImage(ImageSource.camera);
                  Navigator.of(ctx).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('From Camera ')
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await uploadImage(ImageSource.gallery);
                  Navigator.of(ctx).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.photo_outlined,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('From Gallery')
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }

  _signUpSupmit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.save();

      Provider.of<Auth>(context, listen: false).changeIsLoading(true);
      await Provider.of<Auth>(context, listen: false)
          .registerExpert(authDataForm)
          .then((_) {
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
        return CustomDialogForSignUp(
            'Note!', 'For more Safety you must also login');
      }).catchError((error) {
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
      });
    }
  }

  CustomDialogForSignUp(String title, String msg) {
    return AwesomeDialog(
        context: context,
       dialogBackgroundColor: Colors.black,
        btnOkColor: Colors.amber,
        barrierColor: Colors.grey,
        titleTextStyle: TextStyle(color: Colors.white),
        buttonsTextStyle: TextStyle(color: Colors.black),
        descTextStyle: TextStyle(color: Colors.grey),
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: title,
        desc: msg,
        btnCancelOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkOnPress: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              LoginExpert.routeName, (route) => false,
              arguments: {"fromSignup": true});
          Provider.of<Auth>(context, listen: false).changeIsLoading(false);
        })
      ..show();
  }
}
