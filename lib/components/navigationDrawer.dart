import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import '../Utils/shared_preference_helper.dart';
import '../model/user.dart';
import 'drawer.dart';
import 'package:EffeCA/screens/developerinfo.dart';
import 'package:EffeCA/screens/about.dart';
import 'package:EffeCA/screens/contact.dart';
import 'package:EffeCA/screens/leaderboard.dart';
import 'package:EffeCA/screens/message.dart';
import 'package:EffeCA/screens/eventscreen.dart';
import 'package:EffeCA/screens/firstscreen.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  HiddenDrawerController _drawerController;
  User userLoad = new User();
  Future fetchUserDetailsFromSharedPref() async {
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
    fetchUserDetailsFromSharedPref();
    _drawerController = HiddenDrawerController(
      initialPage: FirstScreen(),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          page: FirstScreen(),
        ),
        DrawerItem(
          text: Text(
            'Events',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.event, color: Colors.white),
          page: EventScreen(),
        ),
        DrawerItem(
          text: Text(
            'LeaderBoard',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.group, color: Colors.white),
          page: LeaderboardScreen(),
        ),
        DrawerItem(
          text: Text(
            'About',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info_outline, color: Colors.white),
          page: AboutScreen(),
        ),
        DrawerItem(
          text: Text(
            'Message',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.message, color: Colors.white),
          page: MessageScreen(),
        ),
        DrawerItem(
          text: Text(
            'Developer Info',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.info, color: Colors.white),
          page: DevInfoScreen(),
        ),
        DrawerItem(
          text: Text(
            'Contact',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.call, color: Colors.white),
          page: ContactScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HiddenDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                // height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 2)),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width * 0.4,
                child: ClipOval(
                  child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      userLoad.imageURL??'',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                userLoad.name??'',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                userLoad.email??'',
                style: TextStyle(color: Colors.white70,fontSize: 12)
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB600FF),
             // Color(0xFFD9A2EF),
              Color(0xFFF6CECC),
             // Color(0xFFEBE7F6),
            ],
            // tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
