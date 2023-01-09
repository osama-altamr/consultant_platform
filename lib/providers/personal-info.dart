import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tutorial_app/serverconfig.dart';
import 'package:http/http.dart' as http;
import '../screens/perosnal_info-first.dart';

class InformationProvider with ChangeNotifier {
  static String startTime = DateFormat('hh:mm a').format(DateTime.now());

  String? token;

  static String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(hours: 2)))
      .toString();

  allDataProvider(String? tokenExpert) {
    token = tokenExpert;
    notifyListeners();
  }

  Map availableDays = {
    "Sunday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Monday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Tuesday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Wednesday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Thursday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Friday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
    "Saturday": {
      "switchbool": false,
      "startTime": startTime,
      "endTime": endTime,
    },
  };

  Map<String, dynamic> allInformations = {
    "textConsultation": "Medical",
    "description": "",
    "yearsofexperience": "",
    "specialization": "",
    "workplace": "",
    "linkedinLink": "",
    "dateOfbirth": "",
    "address": "",
    "phoneNumber": "",
    "rating":0.0
  };

  Future sendAllInformations() async {
    Uri baseUrl = Uri.parse(ServerConfig.DNS + ServerConfig.updateinfoExpert);
    print('send info expert $baseUrl');
    try {
      var resoponse = await http.post(baseUrl,
          body: json.encode({
            'category_id': getIdOfCategory(allInformations['textConsultation']),
            'phone': allInformations['phoneNumber'],
            'address': allInformations['address'],
            'workspace_name': allInformations['workplace'],
            'years_of_experience': allInformations['yearsofexperience'],
            'category': allInformations['textConsultation'],
            'specialization': allInformations['specialization'],
            'description': allInformations['description'],
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          });
      print(json.decode(resoponse.body));
    } catch (error) {
      throw error;
    }
  }

  selectedTypeConsultation(FilterOptionConsultation filter) {
    if (filter == FilterOptionConsultation.medical) {
      allInformations['textConsultation'] = 'Medical';
    }
    if (filter == FilterOptionConsultation.professional) {
      allInformations['textConsultation'] = 'Professional';
    }
    if (filter == FilterOptionConsultation.family) {
      allInformations['textConsultation'] = 'Family';
    }
    if (filter == FilterOptionConsultation.psychological) {
      allInformations['textConsultation'] = 'Psychological';
    }
    if (filter == FilterOptionConsultation.business) {
      allInformations['textConsultation'] = 'Business';
    }
    print("Map selectedyType ${allInformations['textConsultation']}");
    notifyListeners();
  }

  int getIdOfCategory(String consultation) {
    int? catId;
    if (consultation == 'Medical') {
      catId = 1;
    }
    if (consultation == 'Family') {
      catId = 2;
    }
    if (consultation == 'Psychological') {
      catId = 3;
    }
    if (consultation == 'Professional') {
      catId = 4;
    }
    if (consultation == 'Business') {
      catId = 5;
    }
    return catId!;
  }

  changeValueOfSwitch(bool val, String day) {
    availableDays[day]['switchbool'] = val;
    notifyListeners();
  }

  convertStartTimeOrEndTime(String formatedDate, String day, bool isStartTime) {
    if (isStartTime) {
      availableDays[day]['startTime'] = formatedDate;
    } else {
      availableDays[day]['endTime'] = formatedDate;
    }
    notifyListeners();
  }
}
