import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:nirmitee/core/enum/view_state.dart';
import 'package:nirmitee/core/services/google_data_source.dart';
import 'package:nirmitee/core/view_models/calender_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalenderViewModel>(
      create: (context) => CalenderViewModel(),
      child: Consumer<CalenderViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (model.state == ViewState.Idle)
                  Navigator.pushNamed(context, 'create_event');
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text('Calendar'),
              actions: [
                IconButton(
                    onPressed: () => model.fetchEvents(),
                    icon: Icon(Icons.refresh))
              ],
            ),
            body: model.state == ViewState.Busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SfCalendar(
                    onTap: (CalendarTapDetails details) =>
                        calendarTapped(details, context),
                    view: CalendarView.week,
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    dataSource: GoogleDataSource(events: model.appointments)),
          );
        },
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details, BuildContext context) {
    String? _subjectText = '',
        _startTimeText = '',
        _endTimeText = '',
        _dateText = '',
        _timeDetails = '';
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Event appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.summary;
      print(_subjectText);
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.start!.dateTime!)
          .toString();
      _startTimeText = DateFormat('hh:mm a')
          .format(appointmentDetails.start!.dateTime!)
          .toString();
      _endTimeText = DateFormat('hh:mm a')
          .format(appointmentDetails.end!.dateTime!)
          .toString();
      if (appointmentDetails.recurringEventId != null) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(''),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('close'))
              ],
            );
          });
    }
  }
}
