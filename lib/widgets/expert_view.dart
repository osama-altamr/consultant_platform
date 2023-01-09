import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/expert_provider.dart';
import 'package:tutorial_app/screens/detail_expert.dart';
import 'package:tutorial_app/serverconfig.dart';
import 'package:tutorial_app/widgets/rating.dart';
import 'package:tutorial_app/widgets/shimmerwidget.dart';

import '../main.dart';

class ExpertView extends StatefulWidget {
  const ExpertView(
      {super.key, required this.allexperts, required this.isloading});
  final List<ExpertObject> allexperts;
  final bool isloading;

  @override
  State<ExpertView> createState() => _ExpertViewState();
}

class _ExpertViewState extends State<ExpertView> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: widget.allexperts.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1100),
            child: SlideAnimation(
              horizontalOffset: 300.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DetailExpertScreen.routeName, arguments: {
                      "idExpert": "",
                    });
                  },
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.white,
                    color: Colors.grey[900],
                    child: ListTile(
                        
                      leading: widget.isloading
                          ? const ShimmerWidget.circular(
                              height: 64,
                              width: 64,
                            )
                          : const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'assets/images/expert.jpg'
                                  // ServerConfig.DNS +
                                  //     '/' +
                                  //     allexperts[index].profileImage,
                                  ),
                            ),
                      title: widget.isloading
                          ? const ShimmerWidget.rectangular(
                              height: 16,
                              width: 60,
                            )
                          : Container(
                              child: Text(
                              widget.allexperts[index].name,
                              style: TextStyle(color: Colors.white70),
                            )),
                      subtitle: widget.isloading
                          ? const ShimmerWidget.rectangular(
                              height: 10,
                              width: 120,
                            )
                          : Rating(
                              ratingCount: widget.allexperts[index].rating),
                      trailing: widget.isloading
                          ? const ShimmerWidget.rectangular(
                              height: 20,
                              width: 20,
                            )
                          : Text(widget.allexperts[index].specialization ?? '',
                              style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
