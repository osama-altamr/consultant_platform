import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/screens/experts-screen.dart';
import 'package:tutorial_app/screens/perosnal_info-first.dart';

import '../providers/expert_provider.dart';
import '../widgets/expert_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static const routeName = '/favorite_screen';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future loadingDelay() async {
    await Future.delayed(Duration(milliseconds: 1700), () {});
  }

  /* 
*/
  bool isloading = false;
  //  late int idCategory;

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
  bool isinit = true;

  @override
  void didChangeDependencies() {
    if (isinit) {
      // var datafromcategory =
      //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      // idCategory = datafromcategory['id'];

      // setState(() {
      //   isloading = true;
      // });
      // print('value in changede ${idCategory}');
      // Provider.of<ExpertProvider>(context, listen: false)
      //     .fetchAllExperts(idCategory)
      //     .then((_) {
      //   loadingDelay().then((_) {
      // _allexperts =
      //     Provider.of<ExpertProvider>(context, listen: false).allExperts;

      //   setState(() {
      //     isloading = false;
      //   });
      // });
      //   });
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    FilterOptionConsultation filterOptionConsultation =
        FilterOptionConsultation.medical;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                  child: Row(children: [
                    const Text(
                      'Favorites',
                      style: TextStyle(
                        color: Colors.amber,
                        fontFamily: 'Courgette',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Spacer(),
                    CustomPopupMenuButton(),
                    SizedBox(
                      width: 10,
                    )
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ExpertView(
                    allexperts: _allexperts,
                    isloading: false,
                  ),
                )
              ],
            )),
      ),
    );
  }

  CustomPopupMenuButton() {
    return PopupMenuButton(
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            child: Text('Medical Only'),
          ),
          PopupMenuItem(
            child: Text('Medical Only'),
          ),
          PopupMenuItem(
            child: Text('Medical Only'),
          ),
        ];
      },
      icon: Icon(
        Icons.settings,
        color: Colors.amber,
      ),
    );
  }
}
