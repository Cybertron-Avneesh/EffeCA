import 'package:EffeCA/components/navigationDrawer.dart';
import 'package:EffeCA/screens/firstscreen.dart';
import 'package:flutter/material.dart';
import 'package:EffeCA/screens/login_page.dart';
import 'screens/firstscreen.dart';
import 'Utils/constants.dart';
import 'Utils/shared_preference_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Effe CA',
        home: FutureBuilder(
          future: SharedPreferenceHelper.getBooleanValue(
            Constants.USER_IS_LOGGED_IN,
          ),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data ? MainWidget() : LoginPage();
            }
            return MainWidget();
          },
        ));
  }
}
