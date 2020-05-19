import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  static const String id = 'leaderboard_screen';
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
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
        title: Text('Leaderboard'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Center(child: Text('This is Leaderboard Screen')),
    );
  }
}
