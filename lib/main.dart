import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tutorial_app/providers/auth.dart';
import 'package:tutorial_app/providers/categories_provider.dart';
import 'package:tutorial_app/providers/expert_provider.dart';
import 'package:tutorial_app/providers/favorite_pro.dart';
import 'package:tutorial_app/providers/language.dart';
import 'package:tutorial_app/providers/messagpro.dart';
import 'package:tutorial_app/providers/personal-info.dart';
import 'package:tutorial_app/screens/available_times.dart';
import 'package:tutorial_app/screens/categories.dart';
import 'package:tutorial_app/screens/allchats.dart';
import 'package:tutorial_app/screens/detail_expert.dart';
import 'package:tutorial_app/screens/experts-screen.dart';
import 'package:tutorial_app/screens/favorite.dart';
import 'package:tutorial_app/screens/getstarted.dart';
import 'package:tutorial_app/screens/homepage.dart';
import 'package:tutorial_app/screens/login-expert.dart';
import 'package:tutorial_app/screens/login-user.dart';
import 'package:tutorial_app/screens/perosnal_info-first.dart';
import 'package:tutorial_app/screens/perosnal_info-second.dart';
import 'package:tutorial_app/screens/booking.dart';

import 'package:tutorial_app/screens/sign-up-expert.dart';

import 'package:tutorial_app/screens/sign-up-user.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var shared=await SharedPreferences.getInstance ();
  shared.clear ();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProxyProvider<Auth, InformationProvider>(
        create: (ctx) => InformationProvider(),
        update: (context, value, previous) =>
            InformationProvider()..allDataProvider(value.token),
      ),
      ChangeNotifierProxyProvider<Auth, ExpertProvider>(
        create: (ctx) => ExpertProvider(),
        update: (context, value, previous) =>
            ExpertProvider()..getdataAuth(value.idAuth, value.token),
      ),
      ChangeNotifierProvider.value(value: CategoryProvider()),
      ChangeNotifierProvider.value(value: ExpertProvider()),
      ChangeNotifierProvider.value(value: LanguageProvider()),
      ChangeNotifierProvider.value(value: FavoriteProvider()),
      ChangeNotifierProvider.value(value: MessageProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
    Consumer<Auth>(
        builder: (ctx, value, _) {
          return value.isAuth
              ? HomePage()
              : FutureBuilder(
                  builder: (ctx, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return GetStartedScreen();
                  },
                  future: value.tryAutoLogin(),
                );
        },
      ), 
      routes: {
        GetStartedScreen.routeName: (_) => GetStartedScreen(),
        SignUpExpertScreen.routeName: (_) => const SignUpExpertScreen(),
        SignUpUserScreen.routeName: (_) => SignUpUserScreen(),
        SignInUserScreen.routeName: (_) => const SignInUserScreen(),
        PersonalInformationExpertScreen.routeName: (_) =>
            PersonalInformationExpertScreen(),
        PersonalInformationExpertSecondScreen.routeName: (_) =>
            const PersonalInformationExpertSecondScreen(),
        HomePage.routeName: (_) => const HomePage(),
        CategoriesScreen.routeName: (_) => CategoriesScreen(),
        ExpertsScreen.routeName: (_) => ExpertsScreen(),
        ChatsScreen.routeName: (_) => ChatsScreen(),
        FavoriteScreen.routeName: (_) => FavoriteScreen(),
        BookingsSreen.routeName: (_) => BookingsSreen(),
        DetailExpertScreen.routeName: (_) => DetailExpertScreen(),
        AvailableTimeForExpert.routeName: (_) => AvailableTimeForExpert(),
        LoginExpert.routeName: (_) => LoginExpert(),
      },
    );
  }
  
}
