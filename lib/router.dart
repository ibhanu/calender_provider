import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nirmitee/ui/auth/auth_view.dart';
import 'package:nirmitee/ui/calender/calender_view.dart';
import 'package:nirmitee/ui/create_event/create_event_view.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthView());
      case 'calender':
        return MaterialPageRoute(builder: (_) => CalenderView());
      case 'create_event':
        return MaterialPageRoute(builder: (_) => CreateEventView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
