import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/personal-info.dart';

class CustomRowAvailableTimes extends StatelessWidget {
  CustomRowAvailableTimes({
    super.key,
    required this.startTimeday,
    required this.endTimeday,
    required this.day,
    required this.valueDay,
  });

  final String startTimeday;
  final String endTimeday;
  final String day;
  final bool valueDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5,
        top: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: FlutterSwitch(
                inactiveTextColor: Colors.black,
                activeTextColor: Colors.black,
                activeColor: Colors.amber,
                width: 92.0,
                height: 35.0,
                activeText: day,

                inactiveText: day,
                valueFontSize: 9.0,
                //  toggleSize: 45.0,
                value: valueDay,
                showOnOff: true,
                borderRadius: 30.0,
                padding: 6.0,
                duration: const Duration(milliseconds: 250),
                onToggle: (val) {
                  Provider.of<InformationProvider>(context, listen: false)
                      .changeValueOfSwitch(val, day);
                },
              ),
            ),
          ),
          CustomExpandedForTime(context, startTimeday, true),
          CustomExpandedForTime(context, endTimeday, false),
        ],
      ),
    );
  }

  CustomExpandedForTime(BuildContext ctx, String time, bool isStart) {
    var infoProvider = Provider.of<InformationProvider>(ctx);
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Transform.scale(
        scale: 0.85,
        child: Container(
          padding: EdgeInsets.only(
            left: 3,
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
              isStart
                  ? Text(
                      infoProvider.availableDays[day]['startTime'],
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text(
                      infoProvider.availableDays[day]['endTime'],
                      style: TextStyle(color: Colors.grey),
                    ),
              IconButton(
                  onPressed: !infoProvider.availableDays[day]['switchbool']
                      ? null
                      : () {
                          if (isStart) {
                            _getTimeFromExpert(ctx, day, isStartTime: true);
                          } else {
                            _getTimeFromExpert(ctx, day, isStartTime: false);
                          }
                        },
                  icon: Icon(
                    Icons.alarm,
                    color: infoProvider.availableDays[day]['switchbool']
                        ? Colors.amber
                        : Colors.grey,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _getTimeFromExpert(BuildContext ctx, String day,
      {required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: ctx,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(hours: 2),
              ),
            ),
    );
    if (_pickedTime != null) {
      String _formattedTime = _pickedTime.format(ctx);
      Provider.of<InformationProvider>(ctx, listen: false)
          .convertStartTimeOrEndTime(_formattedTime, day, isStartTime);
    }
  }
}
