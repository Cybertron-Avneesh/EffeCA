import 'dart:convert';
import 'package:EffeCA/components/drawer.dart';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EffeCA/components/navigationDrawer.dart';
import '../Utils/constants.dart';


final _firestoreLB = Firestore.instance.collection('Leaderboard');

class LeaderboardScreen extends DrawerContent {
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
    Future<bool> _onBackPress(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MainWidget()));
    }
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kSkin,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: widget.onMenuPressed,
          ),
          title: Text('Leaderboard'),

        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: kBgGradient,
            ),
          ),
          child: Center(
              child: StreamBuilder<QuerySnapshot>(
            stream:
                _firestoreLB.orderBy('total_point', descending: true).snapshots(),
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
                    color: kPurple,
                    elevation: 0,
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
        ),
      ),
    );
  }
}

class LBCard extends StatelessWidget {
  LBCard(
      {@required this.name,
        @required this.email,
        @required this.total_point,
        this.rank,
        this.color, this.elevation});

  final String name;
  final String email;
  final int total_point;
  final int rank;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color ?? Colors.white,
        elevation: elevation??20,
        shadowColor: kShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(name),
          subtitle: Text('$total_point pts'),
          leading: CircleAvatar(
            child: Text(rank.toString(), style: TextStyle(fontSize: 16,
                color: kWhite)),
            backgroundColor: kLightPurple,
          ),
        ),
      ),
    );
  }
}
