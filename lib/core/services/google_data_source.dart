import 'package:googleapis/calendar/v3.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({List<Event>? events}) {
    this.appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final Event event = appointments?[index];
    return event.start?.dateTime?.toLocal() ?? DateTime?.now();
  }

  @override
  DateTime getEndTime(int index) {
    final Event event = appointments?[index];
    return event.endTimeUnspecified != null
        ? (event.start!.dateTime!)
        : (event.end!.date != null
            ? event.end!.date!.add(Duration(days: -1))
            : event.end!.dateTime!.toLocal());
  }

  @override
  String getNotes(int index) {
    return appointments?[index].description ?? '';
  }

  @override
  String getSubject(int index) {
    final Event event = appointments?[index];
    return event.summary == null || event.summary!.isEmpty
        ? 'No Title'
        : event.summary ?? '';
  }
}
