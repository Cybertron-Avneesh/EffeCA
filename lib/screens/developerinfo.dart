import 'dart:convert';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DevInfoScreen extends StatefulWidget {
  static const String id = 'devinfo_screen';
  @override
  _DevInfoScreenState createState() => _DevInfoScreenState();
}

class _DevInfoScreenState extends State<DevInfoScreen> {
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
      body: SingleChildScrollView(
        reverse: true,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Heading(
              heading: 'Head App Operations',
            ),
            Developer(
              name: 'Ritik Harchani',
              avatar:
                  'https://avatars2.githubusercontent.com/u/46641571?s=400&u=f758fa76ddf23047aa50eeef64d34bea49933850&v=4',
            ),
            Heading(
              heading: 'App Developers',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Developer(
                  name: 'Ananya Agarwal',
                  avatar:
                      'https://avatars3.githubusercontent.com/u/58395886?s=400&u=c87cf42ef4278e57fa2bbf5c8582f8842946fb6c&v=4',
                ),
                Developer(
                  name: 'Avneesh Kumar',
                  avatar:
                      'https://avatars1.githubusercontent.com/u/54072374?s=400&u=18abe1ec71c0778bd9243751efc07e4928d426b4&v=4',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Developer(
                  name: 'Tejas Agarwal',
                  avatar:
                      'https://scontent.fjai1-2.fna.fbcdn.net/v/t1.0-9/86391803_820283338384126_5781836363435343872_o.jpg?_nc_cat=103&_nc_sid=09cbfe&_nc_oc=AQlrraLNJDBpFz1EaOdQZnyfb-GCR7sOsgbA1i2J0AaeP5NeEEhEYjqo9vsZb6g1PfakjwKw5BcF83BtV6nRrA5S&_nc_ht=scontent.fjai1-2.fna&oh=e26b76adcbc2e77ed9b3f2d3abb3bbc3&oe=5EE92B44',
                ),
                Developer(
                  name: 'Karan Kunwar',
                  avatar:
                      'https://avatars3.githubusercontent.com/u/54117043?s=400&u=3074376ea0434711036f80e742a369b7ee72005c&v=4',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Extracted widget for heading
class Heading extends StatelessWidget {
  const Heading({this.heading});
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Text(
        heading,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

//Widget for developers information i.e. image and name
class Developer extends StatelessWidget {
  const Developer({
    this.name,
    this.avatar,
  });
  final String name;
  final String avatar;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 62,
            backgroundImage: NetworkImage(avatar),
          ),
            decoration: new BoxDecoration(
              color: Colors.black, // border color
              shape: BoxShape.circle,
            ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w300,

            ),
          ),
        )
      ],
    );
  }
}
