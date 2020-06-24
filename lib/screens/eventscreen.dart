import 'dart:convert';
import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/constants.dart';
import 'package:EffeCA/components/navigationDrawer.dart';
import '../Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/drawer.dart';

final _firestoreLeaderboard = Firestore.instance.collection('Leaderboard');
final _firestoreEvent = Firestore.instance.collection('EventList');
User userLoad = new User();
var ScreenWidth;

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
    ScreenWidth = MediaQuery.of(context).size.width;
    Future<bool> _onBackPress() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainWidget()));
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
          title: Text('Events'),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: kBgGradient,
              ),
            ),
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
      ),
    );
  }
}

class EventDetailCard extends StatefulWidget {
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
  _EventDetailCardState createState() => _EventDetailCardState();
}

class _EventDetailCardState extends State<EventDetailCard> {
  bool showProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Card(
        color: Colors.white,
        elevation: 20,
        shadowColor: kShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 5),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: ScreenWidth / 2,
                            child: RichText(
                              maxLines: 3,
                              text: TextSpan(
                                text: widget.url,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launch(widget.url);
                                  },
                              ),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(widget.points.toString(),
                                      style: TextStyle(
                                          color: kPurple, fontSize: 30)),
                                  RotatedBox(
                                    child: Text('pts',
                                        style: TextStyle(color: kLightPurple)),
                                    quarterTurns: -1,
                                  )
                                ]),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              if (widget.uids.contains(userLoad.uid)) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'You have already uploaded for this event')));
                              } else {
                                var tempImage = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (tempImage != null) {
                                  Scaffold.of(context)
                                      .showBottomSheet((context) {
                                    return BuildUploader(
                                        tempImage: tempImage, widget: widget);
                                  });
                                }
                              }
                            },
                            child: Chip(
                              backgroundColor: kSkin,
                              elevation: 2,
                              shadowColor: kShadow,
                              label: Text('Upload Image'),
                              avatar: Icon(Icons.cloud_upload),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              if (showProgressIndicator)
                Center(child: Container(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
  }
}

class BuildUploader extends StatelessWidget {
  const BuildUploader({
    Key key,
    @required this.tempImage,
    @required this.widget,
  }) : super(key: key);

  final File tempImage;
  final EventDetailCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: 450,
      child: Column(
        children: <Widget>[
          Image.file(
            tempImage,
            width: 160,
            height: 350,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CheckButton(widget: widget, tempImage: tempImage),
              CrossButton()
            ],
          )
        ],
      ),
    );
  }
}

class CrossButton extends StatelessWidget {
  const CrossButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.close,
        color: Colors.white,
        size: 50,
      ),
      elevation: 5,
      shape: CircleBorder(),
      fillColor: Colors.red,
      onPressed: () {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Dismissed.'),
        ));
      },
    );
  }
}

class CheckButton extends StatelessWidget {
  const CheckButton({
    Key key,
    @required this.widget,
    @required this.tempImage,
  }) : super(key: key);

  final EventDetailCard widget;
  final File tempImage;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50,
        ),
        elevation: 5,
        shape: CircleBorder(),
        fillColor: Colors.green,
        onPressed: () async {
          Navigator.pop(context);
          var listener =
              DataConnectionChecker().onStatusChange.listen((status) async {
            switch (status) {
              case DataConnectionStatus.connected:
                {
                  print('Data connection is available.');
                  final StorageReference firebasestorageref = FirebaseStorage
                      .instance
                      .ref()
                      .child('${userLoad.uid}/${widget.eventID}');
                  final StorageUploadTask task =
                      firebasestorageref.putFile(tempImage);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return StreamBuilder<StorageTaskEvent>(
                            stream: task.events,
                            builder: (context, snapshot) {
                              return AlertDialog(
                                title: task.isComplete
                                    ? Text('Uploaded')
                                    : Text('Uploading...'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (task.isComplete)
                                        Text('🎉🎉🎉')
                                      else
                                        LinearProgressIndicator(backgroundColor: kLightPurple,),

                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  if (task.isComplete)
                                    FlatButton(
                                      child: Text('Done'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                ],
                              );
                            });
                      });
                  task.onComplete.whenComplete(() {
                    print('--------- Completed --------');
                    _firestoreEvent
                        .document(widget.eventID.toString())
                        .updateData({
                      'uids': FieldValue.arrayUnion([userLoad.uid.toString()])
                    });
                    _firestoreLeaderboard
                        .document(userLoad.uid.toString())
                        .updateData({
                      'total_point': FieldValue.increment(widget.points),
                      'eventIDs': FieldValue.arrayUnion([widget.eventID])
                    });
                  });
                  break;
                }
              case DataConnectionStatus.disconnected:
                {
                  print('You are disconnected from the internet.');
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          '⚠ Upload Error',
                          style: TextStyle(color: Colors.red),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Check your internet connection.'),
                              Text('Try again later.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Okay'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                break;
            }
          });
          await Future.delayed(Duration(seconds: 1));
          await listener.cancel();
        });
  }
}
