import 'package:flutter/foundation.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:nirmitee/core/enum/view_state.dart';
import 'package:nirmitee/core/services/calender_client.dart';

import '../../locator.dart';

class CalenderViewModel extends ChangeNotifier {
  final calendarClient = locator<CalendarClient>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  Events _events = Events();
  List<Event> _appointments = <Event>[];
  List<Event> get appointments => _appointments;

  Events get events => _events;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  CalenderViewModel() {
    fetchEvents();
  }
  fetchEvents() async {
    setState(ViewState.Busy);
    _appointments = [];
    _events = await calendarClient.getEvents();
    if (_events.items != null) {
      for (int i = 0; i < _events.items!.length; i++) {
        final Event event = _events.items![i];
        if (event.start == null) {
          continue;
        }
        _appointments.add(event);
      }
    }
    setState(ViewState.Idle);
  }
}
