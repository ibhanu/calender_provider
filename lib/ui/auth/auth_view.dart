import 'package:flutter/material.dart';
import 'package:nirmitee/core/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Auth View'),
            ),
            body: Center(
              child: TextButton(
                child: Text('Authenticate'),
                onPressed: () async {
                  bool res = await model.onPress();
                  if (res) {
                    Navigator.pushNamed(context, 'calender');
                  } else {
                    print('fail');
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
