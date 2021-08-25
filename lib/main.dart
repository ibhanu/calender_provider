import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nirmitee/locator.dart';
import 'package:nirmitee/router.dart' as r;

Future main() async {
  setupLocator();
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nirmitee',
      theme: ThemeData(),
      initialRoute: '/',
      onUnknownRoute: r.Router.generateRoute,
    );
  }
}
