import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:tutorial_app/serverconfig.dart';

class Category {
  final int id;
  final String name;
  final String image;

  Category(this.id, this.name, this.image);
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  bool isloadingCategory = true;

  Future<void> getCategories() async {
    Uri baseUrl = Uri.parse(ServerConfig.DNS + ServerConfig.getGategories);
    try {
      var resoponse = await http.get(baseUrl);

      List extractedData = json.decode(resoponse.body)['categories'];
      print(extractedData.toString());
      extractedData.forEach((element) {
        _categories.add(
          Category(
            element['id'],
            element['name'],
            getImagesCategories(element['id'])!,
          ),
        );
      });
      isloadingCategory = false;
      notifyListeners();

      print('++++++++++++=====+++++++++++ ');
      print('++++++++++++ GET DATA +++++++++++ ');
      for (int i = 0; i < _categories.length; i++) {
        print(_categories[i].name);
        print(_categories[i].id);
        print(_categories[i].image);
      }
    } catch (error) {
      isloadingCategory = false;
      notifyListeners();
      throw error;
    }
  }

  String? getImagesCategories(int cat) {
    if (cat == 1) return 'assets/images/medical.jpg';
    if (cat == 2) return 'assets/images/family.jpg';
    if (cat == 3) return 'assets/images/psych.jpg';
    if (cat == 4) return 'assets/images/prof.jpg';
    if (cat == 5) return 'assets/images/buisness.jpg';
  }
}
