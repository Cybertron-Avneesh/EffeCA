import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestoreLBDetail = Firestore.instance.collection('Leaderboard');

class FirstScreen extends StatefulWidget {
  static const String id = 'first_screen';
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
    return MaterialApp(
        home: Scaffold(
            drawer: NavDrawer(userLoad: userLoad),
            appBar: AppBar(
              title: Text('Home'),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.more_vert), onPressed: null)
                // Add Logout Feature
              ],
            ),
            body: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  CircularContainer(
                    color: Colors.orange[100],
                    dimension: 180.0,
                  ),
                  CircularContainer(
                    color: Colors.orange[200],
                    dimension: 160.0,
                  ),
                  CircularContainer(
                    color: Colors.orange[300],
                    dimension: 140.0,
                  ),
                  CircularContainer(
                    color: Colors.orange[400],
                    dimension: 120.0,
                  ),
                  CircularContainer(
                    color: Colors.orange[500],
                    dimension: 100.0,
                  ),
                  StreamBuilder(
                    stream: _firestoreLBDetail
                        .orderBy('total_point', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return RefreshProgressIndicator();
                      final users = snapshot.data.documents;
                      int rank = 1;
                      for (var user in users) {
                        if (userLoad.uid == user.data['uid']) {
                          break;
                        }
                        rank++;
                      }
                      return Text(
                        rank.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      );
                    },
                  ),
                ]),
              ),
            )));
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({Key key, this.color, this.dimension})
      : super(key: key);
  final Color color;
  final dimension;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Container(
        width: dimension,
        height: dimension,
        color: color,
      ),
    );
  }
}
