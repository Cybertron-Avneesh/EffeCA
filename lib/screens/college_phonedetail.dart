import 'package:EffeCA/components/navigationDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _fireStoreLB = Firestore.instance.collection('Leaderboard');
String contactNumber;
String college;

class CollegePhoneDetail extends StatefulWidget {
  CollegePhoneDetail({this.uid});
  String uid;

  @override
  _CollegePhoneDetailState createState() => _CollegePhoneDetailState();
}

class _CollegePhoneDetailState extends State<CollegePhoneDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Text('College'),
          TextField(
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              college = value;
            },
          ),
          Text('Contact Number'),
          TextField(
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
            onChanged: (value) {
              contactNumber = value;
            },
          ),
          Spacer(),
          RaisedButton(
            child: Chip(
              label: Text('Proceed'),
              avatar: Icon(
                Icons.arrow_forward,
              ),
            ),
            onPressed: () {
              bool isContactNumberValid = ValidatePhoneNumber(contactNumber);
              if (isContactNumberValid && college != null) {
                _fireStoreLB.document(widget.uid.toString()).setData(
                    {'contactNumber': contactNumber, 'collegeName': college},
                    merge: true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MainWidget();
                    },
                  ),
                );
              }
            },
          )
        ]),
      )),
    );
  }
}

bool ValidatePhoneNumber(String contactNumber) {
  if (contactNumber.length < 10 ||
      contactNumber.contains(new RegExp(r'[a-z]')) ||
      contactNumber.contains(new RegExp(r'[A-Z]'))) {
    return false;
  } else if (contactNumber.length >= 10 &&
      contactNumber.contains(new RegExp(r'[0-9]'))) {
    return true;
  }
}
