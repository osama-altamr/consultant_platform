import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_app/providers/auth.dart';

class BookingsSreen extends StatelessWidget {
  const BookingsSreen({super.key});
  static const routeName = '/booking';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 22),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 12),
                  child: Text(
                    'Bookings',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                        fontFamily: 'Courgette'),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).logout();
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.amber,
                        ))),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundImage:
                        AssetImage('assets/images/generic-person.png'),
                  ),
                ),
                const SizedBox(
                  width: 0,
                )
              ],
            ),
            _addTaskBar(),
            const SizedBox(
              height: 15,
            ),
            DateBar(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return showListBookings();
                },
                itemCount: 3,
              ),
            )
          ]),
        ),
      ),
    );
  }

  showListBookings() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 8, right: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          // color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Colors.amber,
          )),
      child: Column(children: [
        Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(
                CommunityMaterialIcons.book_account,
                color: Colors.black,
              ),
              radius: 15,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Osama Tmr',
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Text(
              '\$ 200',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ',
          style: TextStyle(color: Colors.amber),
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  'Start Time',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '8:00 AM',
                  style: TextStyle(color: Colors.amber),
                )
              ],
            ),
            SizedBox(
              width: 60,
            ),
            Icon(
              Icons.forward,
              color: Colors.amber,
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  'End Time',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '11:00 AM',
                  style: TextStyle(color: Colors.amber),
                )
              ],
            ),
          ],
        )
      ]),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Arvo', fontSize: 20),
            ),
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Arvo', fontSize: 18),
              // style: subHeadingStyle,
            )
          ],
        ),
      ]),
    );
  }



  DateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 6),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.amber[700]!,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        onDateChange: (newDate) {
          // setState(() {
          //   _selectedDate = newDate;
          // });
        },
      ),
    );
  }
}
