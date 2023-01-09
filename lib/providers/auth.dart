// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_app/main.dart';

import 'package:tutorial_app/models/http-exception.dart';

import '../serverconfig.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _name;
  int? _id;
  bool isLoading = false;
  bool personIsExpert = false;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null && _name != null)
      return _token;
    else {
      return null;
    }
  }

  String? get name {
    return _name;
  }

  int? get idAuth {
    return _id;
  }

  changeIsLoading(bool newIsLoading) {
    isLoading = newIsLoading;
    notifyListeners();
  }

  registerUser(Map authData) async {
    Uri urlSignUp = Uri.parse(ServerConfig.DNS + ServerConfig.userRegister);
    print(urlSignUp);
    print(authData['email']);
    try {
      var response = await http.post(
        urlSignUp,
        body: json.encode(
          {
            "name": authData['username'],
            "email": authData['email'],
            "password": authData['password'],
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      authData = json.decode(response.body);
      print("Success auth $authData");
      if (authData['error'] != null) {
        throw HttpException(message: authData['error']);
      }
      _name = authData['user']['name'];
      _id = authData['user']['id'];
      _token = authData['access_Token'];

      notifyListeners();

      setDatatoSharedPrefrences(
        tokenPref: _token!,
        perosnIsExpertPref: personIsExpert,
        namePref: _name!,
        idPref: _id!,
      );
    } catch (error) {}
  }

  registerExpert(Map authData) async {
    Uri urlSignUp = Uri.parse(ServerConfig.DNS + ServerConfig.expertRegister);
    print(urlSignUp);
    print(authData['email']);
    //  personIsExpert = true;
    try {
      var response = await http.post(
        urlSignUp,
        body: json.encode(
          {
            "name": authData['username'],
            "email": authData['email'],
            "password": authData['password'],
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      authData = json.decode(response.body);
      print("Success auth $authData");
      if (authData['error'] != null) {
        throw HttpException(message: authData['error']);
      }
      // _name = authData['expert']['name'];
      // _id = authData['expert']['id'];
      // _token = authData['access_Token'];

      notifyListeners();

      // setDatatoSharedPrefrences(
      //   tokenPref: _token!,
      //   perosnIsExpertPref: personIsExpert,
      //   namePref: _name!,
      //   idPref: _id!,
      // );
    } catch (error) {}
  }

  loginExpert(Map authData) async {
    Uri urlSignUp = Uri.parse(ServerConfig.DNS + ServerConfig.expertLogin);
    print(urlSignUp);
    print(authData['email']);
    personIsExpert = true;
    try {
      var response = await http.post(
        urlSignUp,
        body: json.encode(
          {
            "email": authData['email'],
            "password": authData['password'],
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      authData = json.decode(response.body);
      if (authData['error'] != null) {
        print('Http Exception');
        throw HttpException(message: authData['error']);
      }
      print("Success auth $authData");
      _token = authData['0']['token'];
      _name = authData['0']['name'];
      _id = authData['0']['id'];
      notifyListeners();
      setDatatoSharedPrefrences(
        tokenPref: _token!,
        perosnIsExpertPref: personIsExpert,
        namePref: _name!,
        idPref: _id!,
      );
    } catch (error) {
      throw error;
    }
  }

  loginUser(Map authData) async {
    Uri urlSignUp = Uri.parse(ServerConfig.DNS + ServerConfig.userLogin);
    print(urlSignUp);
    print(authData['email']);
    try {
      var response = await http.post(
        urlSignUp,
        body: json.encode(
          {
            "email": authData['email'],
            "password": authData['password'],
          },
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      authData = json.decode(response.body);
      if (authData['error'] != null) {
        print('Http Exception');
        throw HttpException(message: authData['error']);
      }
      print("Success auth $authData");
      _token = authData['0']['token'];
      _name = authData['0']['name'];
      _id = authData['0']['id'];
      notifyListeners();
      setDatatoSharedPrefrences(
        tokenPref: _token!,
        perosnIsExpertPref: personIsExpert,
        namePref: _name!,
        idPref: _id!,
      );
    } catch (error) {
      rethrow;
    }
  }

  setDatatoSharedPrefrences(
      {required String tokenPref,
      required bool perosnIsExpertPref,
      required String namePref,
      required int idPref}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String allData = json.encode({
      'token': tokenPref,
      'personIsExpert': perosnIsExpertPref,
      'name': namePref,
      'id': idPref,
    });
    sharedPreferences.setString('allData', allData);
  }

  Future<bool> tryAutoLogin() async {
    logger.d('try auto login');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey('allData')) {
      return false;
    }
    var extractedData =
        json.decode(sharedPreferences.getString('allData').toString())
            as Map<String, dynamic>;

    _token = extractedData['token'];
    _name = extractedData['name'];
    personIsExpert = extractedData['personIsExpert'];
    _id = extractedData['id'];

    notifyListeners();
    return true;
  }

  logout() async {
    _token = null;
    _name = null;
    _id = null;
    var shared = await SharedPreferences.getInstance();
    shared.clear();
    notifyListeners() ;
  }
}
