import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/expert_provider.dart';
import 'package:tutorial_app/widgets/expert_view.dart';

import '../screens/detail_expert.dart';
import '../widgets/rating.dart';
import '../widgets/shimmerwidget.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    bool isloading = false;
    var allexperts = Provider.of<ExpertProvider>(context).allExperts;
    var filterExperts =
        allexperts.where((element) => element.name.contains(query)).toList();

    return Scaffold(
        backgroundColor: Colors.black,
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: query == '' ? allexperts.length : filterExperts.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1100),
                child: SlideAnimation(
                  horizontalOffset: 300.0,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            DetailExpertScreen.routeName,
                            arguments: {
                              "idExpert": "",
                            });
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.white,
                        color: Colors.grey[900],
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2020/05/14/02/31/covid-19-5169689__340.jpg'
                                // ServerConfig.DNS +
                                //     '/' +
                                //     allexperts[index].profileImage,
                                ),
                          ),
                          title: Container(
                              child: Text(
                            query == ''
                                ? allexperts[index].name
                                : filterExperts[index].name,
                            style: TextStyle(color: Colors.white70),
                          )),
                          subtitle: Rating(
                            ratingCount: query == ''
                                ? allexperts[index].rating
                                : filterExperts[index].rating,
                          ),
                          trailing: query == ''
                              ? Text(allexperts[index].specialization ?? '',
                                  style: TextStyle(color: Colors.white70))
                              : Text(filterExperts[index].specialization ?? '',
                                  style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
