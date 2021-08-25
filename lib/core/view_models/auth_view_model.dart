import 'package:flutter/foundation.dart';
import 'package:nirmitee/core/services/calender_client.dart';

import '../../locator.dart';

class AuthViewModel extends ChangeNotifier {
  // CalendarClient calendarClient = CalendarClient();
  final calendarClient = locator<CalendarClient>();
  fetchEvents() {
    calendarClient.authenticate();
  }

  Future<bool> onPress() async {
    bool res = await calendarClient.authenticate();
    print(res);
    return true;
  }
}
