import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:tutorial_app/providers/categories_provider.dart';

import '../models/searchdelegate.dart';
import '../providers/expert_provider.dart';
import '../widgets/consultaion-view.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});
  static const routeName = '/categories_screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isError = false;
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategories()
        .then((_) {})
        .catchError((error) {
      setState(() {
        isError = true;
      });
    });

    super.initState();
  }

  GlobalKey<FormState> _formKey = GlobalKey(debugLabel: 'keyCategory');

  @override
  Widget build(BuildContext context) {
    List<Category> allCategories =
        Provider.of<CategoryProvider>(context).categories;
    bool isloading = Provider.of<CategoryProvider>(context).isloadingCategory;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: isloading
            ? Transform.scale(
                scale: 1.5,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: Colors.grey,
                          size: 40,
                          secondRingColor: Colors.amber,
                          thirdRingColor: Colors.amber[700]!,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Loading...')
                    ]))
            : isError
                ? Container(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          scale: 4,
                          child: const Icon(
                            Icons.error_sharp,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Sorry, something's not right,We cannot access our server at the moment,Please change your network connection and restart the app.",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                  )
                : (Container(
                    margin: const EdgeInsets.only(left: 8, right: 8, top: 80),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CircleAvatar(
                            //   radius: 60,
                            //   backgroundColor: Colors.black,
                            //   backgroundImage: AssetImage('assets/images/logo-removebg-preview.png'),
                            // ),
                            // Container(
                            //   height: 70,
                            //   width: 70,
                            //   decoration: const BoxDecoration(
                            //     shape: BoxShape.circle,
                            //   ),
                            //   child: Image.asset(
                            //       ''),
                            // ),
                            // Form(
                            //     key: _formKey,
                            //     child: Transform.scale(
                            //       scale: 0.9,
                            //       child: SearchField(
                            //         suggestions: allCategories
                            //             .map(
                            //               (e) => SearchFieldListItem(e.name,
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(
                            //                         double.infinity),
                            //                     child: GestureDetector(
                            //                       onTap: () {
                            //                         print('hhhh');
                            //                       },
                            //                       child: Card(
                            //                         child: Text(getConsultation(
                            //                             e.name)),
                            //                       ),
                            //                     ),
                            //                   )),
                            //             )
                            //             .toList(),
                            //         suggestionState: Suggestion.expand,
                            //         textInputAction: TextInputAction.next,
                            //         hint: 'Search for expert',
                            //         hasOverlay: false,
                            //         searchStyle: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.black.withOpacity(0.8),
                            //         ),
                            //         validator: (x) {
                            //           if (!allCategories.contains(x) ||
                            //               x!.isEmpty) {
                            //             return 'Please Enter a valid State';
                            //           }
                            //           return null;
                            //         },
                            //         suggestionStyle: TextStyle(),
                            //         searchInputDecoration: InputDecoration(
                            //           suffixIcon: const Icon(Icons.search),
                            //           focusedBorder: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(18),
                            //             borderSide: BorderSide(
                            //               color: Colors.red.withOpacity(0.8),
                            //             ),
                            //           ),
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.circular(18),
                            //             borderSide: const BorderSide(
                            //                 color: Colors.red, width: 0.7),
                            //           ),
                            //         ),
                            //         maxSuggestionsInViewPort: 6,
                            //         itemHeight: 50,
                            //       ),
                            //     )),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                'Consultations',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: 'Courgette',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            ConsultationView(
                              categories: allCategories,
                            ),
                          ]),
                    ),
                  )),
      ),
    );
  }
}


/* 


            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Osama Tmr',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Courgette',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: Transform.scale(
                    scale: 1.2,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.red),
              ),
            ) */