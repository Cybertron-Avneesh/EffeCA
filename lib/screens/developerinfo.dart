import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';

class DevInfoScreen extends StatefulWidget {
  static const String id = 'devinfo_screen';
  @override
  _DevInfoScreenState createState() => _DevInfoScreenState();
}

class _DevInfoScreenState extends State<DevInfoScreen> {
  User userLoad = new User();

  Future funcThatMakesAsyncCall() async {
    var result =
        await SharedPreferenceHelper.getStringValue(Constants.USER_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    setState(() {
      userLoad = user;
    });
  }

  @override
  void initState() {
    super.initState();
    funcThatMakesAsyncCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(userLoad: userLoad),
      appBar: AppBar(
        title: Text('Developer info'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Center(child: Text('This is Developer info Screen')),
    );
  }
}
