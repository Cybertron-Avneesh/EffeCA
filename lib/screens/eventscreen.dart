import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


final fbref =
    FirebaseDatabase.instance.reference().child(Constants.EVENTS_LIST);

class EventScreen extends StatefulWidget {
  static const String id = 'event_screen';
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  User userLoad = new User();

  Future funcThatMakesAsyncCall() async {
    var result =
        await SharedPreferenceHelper.getStringValue(Constants.EVENTS_LIST);
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
        title: Text('Events'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          ListDataStream(ref: fbref),
        ],
      )),
    );
  }
}

class ListDataStream extends StatelessWidget {
  const ListDataStream({
    Key key,
    @required this.ref,
  }) : super(key: key);

  final Query ref;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: ref.onValue,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final eventDetails = snapshot.data.snapshot.value;
            List<EventDetailCard> eventDetailCards = [];
            for (var eventDetail in eventDetails) {
              final title = eventDetail['title'];
              final url = eventDetail['url'];
              final points = eventDetail['points'];
              final eventDetailCard = EventDetailCard(
                title: title,
                url: url,
                points: points,
              );
              eventDetailCards.add(eventDetailCard);
            }

            return Expanded(
                child: ListView(
              children: eventDetailCards,
            ));
          } else {
            return Text(snapshot.error.toString());
          }
        });
  }
}

class EventDetailCard extends StatelessWidget {
  EventDetailCard({this.title, this.url, this.points});

  final String title;
  final String url;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[300],
      elevation: 20,
      shadowColor: Colors.purple[200],

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.white,),
                ),
                Text(url, maxLines: 3, style: TextStyle(color: Colors.black, fontSize: 14),)
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text(points.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    RotatedBox(
                      child: Text('pts', style: TextStyle(color: Colors.white60)),
                      quarterTurns: -1,
                    )
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
