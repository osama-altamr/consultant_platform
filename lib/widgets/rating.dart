import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/personal-info.dart';

class Rating extends StatelessWidget {
  Rating({
    Key? key,
    required this.ratingCount,
  }) : super(key: key);

  final int ratingCount;

  List<Widget> _starList = [];

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        RatingBar.builder(
          initialRating: ratingCount.toDouble(),
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemPadding: EdgeInsets.all(0.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            Provider.of<InformationProvider>(context, listen: false)
                .allInformations['rating'] = rating;
          },
        )
      ]),
    );
  }

//  Row(mainAxisAlignment: MainAxisAlignment.start, children: _starList),
//     );

  // buildContainer() {
  //   for (int i = 0; i < 5; i++) {
  //     if (i < ratingCount) {
  //       _starList.add(Icon(
  //         Icons.star,
  //         color: Colors.amber,
  //       ));
  //     } else {
  //       _starList.add(Icon(
  //         Icons.star_border,
  //         color: Colors.grey,
  //       ));
  //     }
  //   }
}
