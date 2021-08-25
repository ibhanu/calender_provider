import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:nirmitee/core/view_models/create_new_event_view_model.dart';
import 'package:provider/provider.dart';

class CreateEventView extends StatelessWidget {
  const CreateEventView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateEventViewModel>(
      create: (context) => CreateEventViewModel(),
      child: Consumer<CreateEventViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create Event'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${DateFormat('MMMM dd, yyyy hh:mm a').format(model.startTime).toString()}',
                          style: TextStyle(fontSize: 25),
                        ),
                        IconButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 3, 5),
                                maxTime: DateTime(2200, 6, 7),
                                onChanged: (date) {
                                  print('change $date');
                                },
                                onConfirm: (date) =>
                                    model.updateStartDate(date),
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${DateFormat('MMMM dd, yyyy hh:mm a').format(model.endTime).toString()}',
                          style: TextStyle(fontSize: 25),
                        ),
                        IconButton(
                          onPressed: () {
                            DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2019, 3, 5),
                                maxTime: DateTime(2200, 6, 7),
                                onChanged: (date) {
                                  print('change $date');
                                },
                                onConfirm: (date) => model.updateEndDate(date),
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      controller: model.eventName,
                      decoration: InputDecoration(hintText: 'Enter Event name'),
                    ),
                    ElevatedButton(
                      child: Text(
                        'Insert Event',
                      ),
                      onPressed: () async {
                        bool res = await model.insertEvent();
                        if (res) {
                          print('passed');
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'calender', (route) => false);
                        } else {
                          print('failed');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
