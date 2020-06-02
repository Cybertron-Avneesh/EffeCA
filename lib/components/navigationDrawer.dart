import 'dart:convert';
import 'package:EffeCA/screens/login_page.dart';
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
import 'package:EffeCA/screens/sign_in.dart';

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
          text: 'Home',
          icon: Icons.home,
          page: FirstScreen(),
        ),
        DrawerItem(
          text: 'Events',
          icon: Icons.event,
          page: EventScreen(),
        ),
        DrawerItem(
          text: 'LeaderBoard',
          icon: Icons.group,
          page: LeaderboardScreen(),
        ),
        DrawerItem(
          text: 'About',
          icon: Icons.info_outline,
          page: AboutScreen(),
        ),
        DrawerItem(
          text: 'Message',
          icon: Icons.message,
          page: MessageScreen(),
        ),
        DrawerItem(
          text: 'Developer Info',
          icon: Icons.info,
          page: DevInfoScreen(),
        ),
        DrawerItem(
          text: 'Contact',
          icon: Icons.call,
          page: ContactScreen(),
        ),
        DrawerItem(
          text: 'Logout',
          icon: Icons.power_settings_new,
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Do you want to logout?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'No',
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                FirstScreen();
                                signOutGoogle();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginPage()),
                                    ModalRoute.withName('/'));
                              },
                              /*Navigator.of(context).pop(true)*/
                              child: Text('Yes'),
                            ),
                          ],
                        )) ??
                false;
          },
          page: FirstScreen(),
        )
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
                      userLoad.imageURL ?? '',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                userLoad.name ?? '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(userLoad.email ?? '',
                  style: TextStyle(color: Colors.white70, fontSize: 12))
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
