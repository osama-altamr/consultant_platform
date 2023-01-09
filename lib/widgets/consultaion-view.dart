import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/screens/experts-screen.dart';
import 'package:tutorial_app/serverconfig.dart';
import 'package:tutorial_app/widgets/indicator.dart';

import '../providers/auth.dart';
import '../providers/categories_provider.dart';

class ConsultationView extends StatefulWidget {
  final List<Category> categories;
  const ConsultationView({super.key, required this.categories});

  @override
  State<ConsultationView> createState() => _ConsultationViewState();
}

class _ConsultationViewState extends State<ConsultationView> {
  int _current = 0;
  @override
  void initState() {
    print(Provider.of<Auth>(context, listen: false).token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        itemCount: widget.categories.length,
        itemBuilder: (ctx, index, _) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ExpertsScreen.routeName, arguments: {
                'name': getConsultation(widget.categories[index].name),
                "id": widget.categories[index].id,
              });
            },
            child: Container(
              width: 230,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                shadowColor: Colors.amber,
                margin: const EdgeInsets.all(10),
                child: Stack(fit: StackFit.expand, children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.asset(widget.categories[index].image,fit: BoxFit.cover,),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.only(
                          left: 17, bottom: 10, right: 17, top: 8),
                      child: Row(children: [
                        Container(
                          width: 125,
                          child: Text(
                            '${getConsultation(widget.categories[index].name)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Anton',
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                color: Colors.amber, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.forward_outlined,
                              color: Colors.black,
                            )),
                      ]),
                    ),
                  )
                ]),
              ),
            ),
          );
        },
        options: CarouselOptions(
            viewportFraction: .65,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            aspectRatio: 2.7 / 2.6,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Indicator(
        index: _current,
      ),
    ]);
  }
}

getConsultation(String name) {
  String consultation = '';
  switch (name) {
    case "medical_consultation":
      consultation = 'Medical';
      break;
    case "family_consultation":
      consultation = 'Family';
      break;
    case "psychological_consultation":
      consultation = 'Psychological';
      break;
    case "professional_consultation":
      consultation = 'Professional';
      break;
    case "buisness_and_managment_consultation":
      consultation = 'Buisness and Managment';
      break;
    default:
      'Consultation';
  }
  return consultation;
}
