import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        title: Text('About'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(4),
              elevation: 6,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'About CA Program',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        Constants.AboutCAProgramDescription,
                        maxLines: 20,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
