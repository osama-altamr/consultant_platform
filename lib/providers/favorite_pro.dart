import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/models/http-exception.dart';
import 'package:tutorial_app/serverconfig.dart';

class FavoriteProvider with ChangeNotifier {
  bool isFavorite = false;
  List allFavorites = [];
  void setFavoriteValue(bool newVal) {
    isFavorite = newVal;
    notifyListeners();
  }

  Future getFavorites(String token, int idUser) async {
    try {
      Uri url = Uri.parse(ServerConfig.DNS + '');
      final res = await http.get(url);
      if (res.statusCode > 200) {
        throw HttpException(message: json.decode(res.body));
      }
      final extractedData = json.decode(res.body);
      logger.i(extractedData);
    } catch (error) {}
  }

  Future toggleFavoriteStatus(
    int idExpert,
    String nameExpert,
  ) async {
    final bool oldStatusFav = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      Uri url = Uri.parse(ServerConfig.DNS + '');
      final res = await http.post(url,
          body: json.encode({
            // "": isFavorite,
            // "": nameExpert,
            // ""
          }));
      if (res.statusCode > 200) {
        setFavoriteValue(oldStatusFav);
      }
    } catch (error) {
      setFavoriteValue(oldStatusFav);
    }
  }
}
