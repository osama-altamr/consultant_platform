import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/favorite_pro.dart';
import 'package:tutorial_app/widgets/rating.dart';

import '../providers/auth.dart';
import '../providers/expert_provider.dart';

class DetailExpertScreen extends StatefulWidget {
  DetailExpertScreen({super.key});
  static const routeName = '/detail-expert';

  @override
  State<DetailExpertScreen> createState() => _DetailExpertScreenState();
}

class _DetailExpertScreenState extends State<DetailExpertScreen> {
  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek("Tue", isSelected: true),
    // DayInWeek(
    //   "Wed",
    // ),
    DayInWeek(
      "Thu",
    ),
    // DayInWeek(
    //   "Fri",
    // ),
    DayInWeek(
      "Sat",
    ),
  ];
  ExpertDetail _expertDetail = ExpertDetail.detail(
    id: 0,
    name: 'Sedra Mh',
    description:
        'The placeholder text, beginning with the line “Lorem ipsum dolor sit amet, consectetur adipiscing elit”, looks like Latin because in its youth, centuries ago, it was Latin.',
    address: 'Syria|Damascus|D',
    phone: '+0439439949',
    yearsExperience: 3,
    specialization: 'Doctor',
    workplace: 'Company',
  );
  bool isloading = false;
  @override
  void initState() {
    // setState(() {
    //   isloading = true;
    // });
    // Provider.of<ExpertProvider>(context, listen: false)
    //     .fetchAnyExpert(205)
    //     .then((value) {
    //   _expertDetail = ExpertDetail.detail(
    //     id: 205,
    //     name: value['experts']['name'],
    //     description: value['experts']['description'],
    //     address: value['experts']['address'],
    //     phone: value['experts']['phone'],
    //     yearsExperience: value['experts']['years_of_experience'],
    //     specialization: value['experts']['specialization'],
    //     workplace: value['experts']['workspace_name'],
    //   );
    //   setState(() {
    //     isloading = false;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = Provider.of<FavoriteProvider>(context).isFavorite;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.amber,
              ))
            : Container(
                margin: EdgeInsets.only(left: 8, top: 10, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: Colors.amber,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                              child: AvatarGlow(
                            glowColor: Colors.amber,
                            endRadius: 70.0,
                            duration: Duration(milliseconds: 2000),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration: Duration(milliseconds: 100),
                            child: Material(
                              // Replace this child with your own
                              elevation: 100.0,
                              shape: CircleBorder(
                                  side: BorderSide(
                                color: Colors.amber,
                                width: 1,
                              )),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                backgroundImage:
                                    AssetImage('assets/images/expert.jpg'),
                                radius: 50,
                              ),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    _expertDetail.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Arvo'),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    _expertDetail.specialization,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      // fontFamily: 'Arvo'
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber.withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.chat,
                                              color: Colors.amber[400],
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber.withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.call,
                                              color: Colors.amber,
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber.withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.video_call,
                                              color: Colors.amber,
                                            )),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'phone :',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${_expertDetail.phone}',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Row(
                        children: [
                          Text(
                            'Workplace :',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '${_expertDetail.workplace}',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - ',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text(
                        'About',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _expertDetail.description,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Row(children: [
                        Text(
                          'Ratings',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Rating(ratingCount: 5),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '2.5 M',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Address',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Icon(
                            Icons.emoji_events,
                            color: Colors.amber,
                          ),
                          Text(
                            'Yrs Experience',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            _expertDetail.address.split('|')[0],
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            _expertDetail.address.split('|')[1],
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            _expertDetail.address.split('|')[2],
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: 75,
                          ),
                          Text(
                            '+${_expertDetail.yearsExperience.toString()}',
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

// availabe days
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.amber,
                          mini: true,
                          heroTag: _expertDetail.id,
                          onPressed: () {
                            Provider.of<FavoriteProvider>(context,
                                    listen: false)
                                .setFavoriteValue(!isFavorite);
                          },
                          child: isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 8)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber[500]),
                          ),
                          onPressed: () {
                            availableTimesBottomSheet(context);
                          },
                          child: Text('Book Appoinment',
                              style: TextStyle(color: Colors.black)),
                        )
                      ],
                    ),
                  ],
                )),
      ),
    );
  }

  availableTimesBottomSheet(ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.black,
        context: ctx,
        builder: (conte) {
          return Container(
            height: 310,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                margin: EdgeInsets.only(top: 10,left: 150),
                height: 10,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Row(
                  children: const [
                    Text(
                      '  av days',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SelectWeekDays(
                  backgroundColor: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  days: _days,
                  onSelect: (values) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text(
                  '  av times',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.80,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'start time',
                                style: TextStyle(color: Colors.grey),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.90,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 0,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'end time',
                                style: TextStyle(color: Colors.grey),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(height: 40,),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Book now',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 80)),
                    backgroundColor: MaterialStateProperty.all(Colors.amber[500]),
                  ),
                ),
              )
            ]),
          );
        });
  }
}

class ExpertDetail {
  final int id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final int yearsExperience;
  final String specialization;
  final String workplace;

  const ExpertDetail.detail({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.yearsExperience,
    required this.specialization,
    required this.workplace,
  });
}
