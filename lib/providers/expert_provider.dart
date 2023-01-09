// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/serverconfig.dart';

class ExpertObject {
  final String name;
  final int rating;
  final String profileImage;
  String? specialization;
  ExpertObject({
    required this.name,
    required this.rating,
    required this.profileImage,
    this.specialization,
  });
}

class ExpertProvider with ChangeNotifier {
double midRating =0.0 ;
  List<ExpertObject> _allexperts = [];
  List<ExpertObject> get allExperts {
    return _allexperts;
  }

  int? idauth;
  String? tokenAuth;
  getdataAuth(int? id, String? token) {
    idauth = id;
    tokenAuth = token;
    notifyListeners();
  }

  Future fetchAnyExpert(int id) async {

    Uri url = Uri.parse(ServerConfig.DNS + "/api/details/$id");
    try {
      var response = await http.get(url);
      print(json.decode(response.body));
      notifyListeners();
      return json.decode(response.body);
    } catch (error) {}
  }

  Future fetchAllExperts(int categoryId) async {
    Uri baseUrl =
        Uri.parse(ServerConfig.DNS + '/api/categories/$categoryId/experts');
    try {
      var response = await http.get(baseUrl);
      print("fetch All Expertsssssss");
      print(json.decode(response.body));

      List extractedData = json.decode(response.body)["experts"];
      _allexperts=[];
      extractedData.forEach((element) {
        print('Eleeemeeent');
        print(element);
     
        _allexperts.add(ExpertObject(
          name: element['name'],
          rating: element['rating'],
          profileImage: element['profile_image'],
          specialization: element['specialization'],
        ));
      });
      logger.d("length for all experts${_allexperts.length}");
      print('vallueee $extractedData');
      notifyListeners();
    } catch (error) {}
  }


  medinRatings() 
  {
    
  }
}
