import 'dart:convert';
import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/providers/language.dart';
import 'package:tutorial_app/screens/getstarted.dart';
import 'package:tutorial_app/screens/homepage.dart';
import 'package:tutorial_app/screens/login-user.dart';
import 'package:tutorial_app/widgets/textformfield.dart';
import 'package:http/http.dart' as http;

class SignUpUserScreen extends StatefulWidget {
  static const routeName = '/sign-up-user';

  @override
  State<SignUpUserScreen> createState() => _SignUpUserScreenState();
}

class _SignUpUserScreenState extends State<SignUpUserScreen> {
  TextEditingController controllerConfirmPassword = TextEditingController();
  XFile? _xFile;
  ImagePicker _imagePicker = ImagePicker();
  Map<String, String> authDataForm = {
    "username": '',
    "email": '',
    "password": '',
  };
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
              margin: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 60,
              ),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: FloatingActionButton(
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
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        top: 10,
                      ),
                      child: Text(
                        providerLang.getText('title_signup_user'),
                        style: TextStyle(
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
                                  color: Colors.black,
                                  offset: Offset(2, 2)),
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.white,
                                  offset: Offset(2, 2)),
                            ]),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      style: TextStyle(color: Colors.grey),
                      keyboardType: TextInputType.name,
                      decoration: CustomInputDecoration(
                          providerLang.getText('full_name_signup'),
                          const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          )),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 5) {
                          return 'Invalid name';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        authDataForm['username'] = val!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.grey),
                      cursorColor: Colors.amber,
                      keyboardType: TextInputType.emailAddress,
                      decoration: CustomInputDecoration(
                          providerLang.getText('email_signup'),
                          const Icon(
                            CommunityMaterialIcons.facebook_workplace,
                            color: Colors.white,
                          )),
                      validator: (val) {
                        if (val!.isEmpty || !val.contains('@')) {
                          return 'Invalid-email!';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        authDataForm['email'] = val!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: CustomInputDecoration(
                          providerLang.getText('password_signup'),
                          const Icon(
                            Icons.lock,
                            color: Colors.white,
                          )),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 6) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        authDataForm['password'] = val!;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      cursorColor: Colors.amber,
                      style: TextStyle(color: Colors.grey),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: CustomInputDecoration(
                          providerLang.getText('confirm_password_singup'),
                          const Icon(
                            Icons.code_off,
                            color: Colors.white,
                          )),
                      validator: (val) {
                        if (controllerConfirmPassword.text !=
                            authDataForm['password']) {
                          return '';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 20, right: 8.0),
                      child: Builder(builder: (ctx) {
                        return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                horizontal: 100,
                              ))),
                          onPressed: () async {
                            await _signUpSupmit();
                          },
                          child: isLoading
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                  providerLang.getText('signup'),
                                  style: TextStyle(color: Colors.black),
                                )),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          providerLang.getText('if_haveaccount'),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                SignInUserScreen.routeName);
                          },
                          child: Text(
                            providerLang.getText('signin'),
                            style: TextStyle(
                              color: Colors.amber,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _signUpSupmit() async {
    if (!_globalKey.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      _globalKey.currentState!.save();
      Provider.of<Auth>(context, listen: false).changeIsLoading(true);
      await Provider.of<Auth>(context, listen: false)
          .registerUser(authDataForm)
          .then((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (cotx) {
              return AlertDialog(
                title: Text('Authentication failed'),
                content: Text('Please try again'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(cotx).pop();
                      },
                      child: Text('Cancel'))
                ],
              );
            });
        Provider.of<Auth>(context, listen: false).changeIsLoading(false);
      });
    }
  }

  uploadImage(ImageSource imageSource) async {
    var pickedImage = await _imagePicker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        _xFile = XFile(pickedImage.path);
      });
    } else {
      print('Null in method upload Image');
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
                      Text('From Gallery ')
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }
}


/* 
 child: Container(
                        margin: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 8,
                        ),
                        child: Column(
                          children: [
                         
                          ],
                        ),
                      )),
            ), */