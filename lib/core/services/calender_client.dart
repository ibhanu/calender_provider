import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/calendar/v3.dart';
import "package:googleapis_auth/auth_io.dart";
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static const _scopes = const [CalendarApi.calendarScope];
  final _clientID = new ClientId(dotenv.env['clientID']!, "");
  late CalendarApi calendar;

  Future<bool> authenticate() async {
    try {
      await clientViaUserConsent(_clientID, _scopes, prompt)
          .then((AuthClient client) {
        calendar = CalendarApi(client);
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  insert(title, startTime, endTime) async {
    String calendarId = "primary";
    Event event = Event(); // Create object of event

    event.summary = title;

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:00";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:00";
    end.dateTime = endTime;
    event.end = end;
    try {
      await calendar.events.insert(event, calendarId).then((value) {
        print("ADDEDDD_________________${value.status}");
        if (value.status == "confirmed") {
          log('Event added in google calendar');
        } else {
          log("Unable to add event in google calendar");
          return false;
        }
      });
      return true;
    } catch (e) {
      log('Error creating event $e');
      return false;
    }
  }

  getEvents() async {
    print('GET EVENTS');
    String calendarId = "primary";
    DateTime timeMin = DateTime(DateTime.now().year, DateTime.now().month);
    DateTime timeMax = DateTime(DateTime.now().year, DateTime.now().month + 1);

    Events events = await calendar.events.list(calendarId,
        timeMin: timeMin.toUtc(), timeMax: timeMax.toUtc(), maxResults: 100);
    return events;
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    try {
      await launch(url);
    } catch (e) {
      print(e);
    }
  }
}
