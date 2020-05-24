import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/drawer.dart';

final _firestoreLeaderboard = Firestore.instance.collection('Leaderboard');
final _firestoreEvent = Firestore.instance.collection('EventList');
User userLoad = new User();

class EventScreen extends DrawerContent {
  static const String id = 'event_screen';
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: widget.onMenuPressed,
        ),
        title: Text('Events'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: _firestoreEvent.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }

              final eventDetails = snapshot.data.documents;
              List<EventDetailCard> eventDetailCards = [];
              for (var eventDetail in eventDetails) {
               
                // Note - eventID to kept same as documentID while creating a new event

                final eventID = eventDetail.data['eventID'];
                final eventTitle = eventDetail.data['title'];
                final point = eventDetail.data['point'];
                final url = eventDetail.data['url'];
                final uids = eventDetail.data['uids'];

                final eventdetailcard = EventDetailCard(
                  eventID: eventID,
                  title: eventTitle,
                  points: point,
                  url: url,
                  uids: uids,
                );
                eventDetailCards.add(eventdetailcard);
              }
              print(userLoad);
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  children: eventDetailCards,
                ),
              );
            },
          )
        ],
      )),
    );
  }
}

class EventDetailCard extends StatelessWidget {
  EventDetailCard({
    @required this.eventID,
    @required this.title,
    @required this.url,
    @required this.points,
    @required this.uids,
  });
  final int eventID;
  final String title;
  final String url;
  final int points;
  final uids;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[300],
      elevation: 20,
      shadowColor: Colors.purple[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      url,
                      maxLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                        RotatedBox(
                          child: Text('pts',
                              style: TextStyle(color: Colors.white60)),
                          quarterTurns: -1,
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    onPressed: () async {
                      if (uids.contains(userLoad.uid)) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'You have already uploaded for this event')));
                      } else {
      
                        var tempImage = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        Scaffold.of(context).showBottomSheet((context) {
                          return Container(
                            height: 400,
                            color: Colors.purple[50],
                            child: Column(
                              children: <Widget>[
                                Image.file(
                                  tempImage,
                                  width: 160,
                                  height: 350,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.check,
                                            color: Colors.green),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          final StorageReference
                                              firebasestorageref =
                                              FirebaseStorage.instance
                                                  .ref()
                                                  .child(
                                                      '${userLoad.email}/${url.replaceAll('/', '')}');
                                          final StorageUploadTask task =
                                              firebasestorageref
                                                  .putFile(tempImage);
                                          Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Uploaded Successfully'),
                                                
                                          ));
                                          _firestoreEvent
                                              .document(eventID.toString())
                                              .updateData({
                                            'uids': FieldValue.arrayUnion(
                                                [userLoad.uid.toString()])
                                          });
                                          _firestoreLeaderboard
                                              .document(
                                                  userLoad.uid.toString())
                                              .updateData({
                                            'total_point': FieldValue.increment(points)
                                          });
                                        }),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Dismissed.'),
                                         
                                        ));
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                      }
                    },
                    child: Chip(
                      label: Text('Upload Image'),
                      avatar: Icon(Icons.cloud_upload),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
