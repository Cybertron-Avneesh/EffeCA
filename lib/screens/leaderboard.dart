import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _firestoreLB = Firestore.instance.collection('Leaderboard');

class LeaderboardScreen extends StatefulWidget {
  static const String id = 'leaderboard_screen';
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
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
        title: Text('Leaderboard'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: _firestoreLB.orderBy('total_point',descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final leaderDetails = snapshot.data.documents;
          List<LBCard> LBCards = [];
          int index = 1;
         
          for (var detail in leaderDetails) {
            
            var lbCard;
            final name = detail.data['name'];
            final email = detail.data['email'];
            final tPoint = detail.data['total_point'];
            print(detail);
            if (email == userLoad.email) {
              lbCard = LBCard(
                name: name,
                email: email,
                total_point: tPoint,
                rank: index,
                color: Colors.blue,
              );
            } else {
              lbCard = LBCard(
                name: name,
                email: email,
                total_point: tPoint,
                rank: index,
              );
            }
            LBCards.add(lbCard);
            index++;
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              children: LBCards,
            ),
          );
        },
      )),
    );
  }
}

class LBCard extends StatelessWidget {
  LBCard(
      {@required this.name,
      @required this.email,
      @required this.total_point,
      this.rank,
      this.color});

  final String name;
  final String email;
  final int total_point;
  final int rank;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Colors.white,
      elevation: 20,
      child: ListTile(
        title: Text(name),
        subtitle: Text('$total_point pts'),
        leading: CircleAvatar(
            child: Text(rank.toString(), style: TextStyle(fontSize: 16))),
      ),
    );
  }
}
