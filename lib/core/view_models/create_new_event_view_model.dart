import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nirmitee/core/services/calender_client.dart';

import '../../locator.dart';

class CreateEventViewModel extends ChangeNotifier {
  final calendarClient = locator<CalendarClient>();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController eventName = TextEditingController();

  Future<bool> insertEvent() async {
    bool res = await calendarClient.insert(eventName.text, startTime, endTime);
    return res;
  }

  updateStartDate(DateTime date) {
    print(date);
    startTime = date;
    notifyListeners();
  }

  updateEndDate(DateTime date) {
    endTime = date;
    notifyListeners();
  }
}
