// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/providers/expert_provider.dart';
import 'package:tutorial_app/screens/categories.dart';

import '../models/searchdelegate.dart';
import '../providers/categories_provider.dart';
import '../widgets/expert_view.dart';
import '../widgets/rating.dart';
import '../widgets/shimmerwidget.dart';
import 'detail_expert.dart';

class ExpertsScreen extends StatefulWidget {
  const ExpertsScreen({super.key});
  static const routeName = '/experts-screen';

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState();
}

class _ExpertsScreenState extends State<ExpertsScreen> {
  Future loadingDelay() async {
    await Future.delayed(Duration(milliseconds: 1700), () {});
  } /* 
*/

  bool isloading = false;
  late int idCategory;
  late String nameCategory;

  File? image;

  bool isinit = true;
  List<ExpertObject> _allexperts = [
    ExpertObject(
        name: 'Osama',
        rating: 3,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
    ExpertObject(
        name: 'Osama',
        rating: 2,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
    ExpertObject(
        name: 'Osama',
        rating: 1,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
    ExpertObject(
        name: 'Osama',
        rating: 5,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
    ExpertObject(
        name: 'Osama',
        rating: 7,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
    ExpertObject(
        name: 'Osama',
        rating: 8,
        profileImage:
            'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'),
  ];
  @override
  void didChangeDependencies() {
    if (isinit) {
      var datafromcategory =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      idCategory = datafromcategory['id'];
      nameCategory = datafromcategory['name'];
      setState(() {
        isloading = true;
      });
      print('value in changede ${idCategory}');
      Provider.of<ExpertProvider>(context, listen: false)
          .fetchAllExperts(idCategory)
          .then((_) {
        loadingDelay().then((_) {
          _allexperts =
              Provider.of<ExpertProvider>(context, listen: false).allExperts;
          print('value in changede ${_allexperts[0].name}');

          setState(() {
            isinit = false;
            isloading = false;
          });
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Text(
                        '$nameCategory',
                        style: TextStyle(
                          color: Colors.amber,
                          fontFamily: 'Courgette',
                          fontWeight: FontWeight.bold,
                          fontSize: nameCategory == "Buisness and Managment"
                              ? 15
                              : 25,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.amber,
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: ExpertView(
                  allexperts: _allexperts,
                  isloading: isloading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
