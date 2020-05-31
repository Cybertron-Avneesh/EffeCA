import 'package:EffeCA/components/navigationDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EffeCA/Utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: kBgGradient,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'College',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: kDarkPurple),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Ex: IIIT Allahabad'),
                  keyboardType: TextInputType.multiline,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    college = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contact Number',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: kDarkPurple),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Ex: 9123444444'),
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  onChanged: (value) {
                    contactNumber = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Colors.transparent,
                  child: Chip(
                    labelPadding:
                        EdgeInsets.only(top: 7, bottom: 7, right: 7, left: 0),
                    backgroundColor: kDarkPurple,
                    label: Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    avatar: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (validateEntries(contactNumber, college)) {
                      _fireStoreLB.document(widget.uid.toString()).setData({
                        'contactNumber': contactNumber,
                        'collegeName': college
                      }, merge: true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return MainWidget();
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            ]),
      )),
    );
  }
}

bool validateEntries(String contactNumber, String collegeName) {
  if (contactNumber == null || collegeName == null) {
    if(contactNumber == null && collegeName == null)
    Fluttertoast.showToast(msg: 'Can\'t proceed without filling them');
    else if(contactNumber == null)
    Fluttertoast.showToast(msg: 'Enter Contact Number');
    else if(collegeName == null)
    Fluttertoast.showToast(msg: 'Enter College Name');
  } 
  else if (contactNumber != null && collegeName != null) {
    Pattern pattern = r'^(?:[+])?[0-9, ]{10,14}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(contactNumber)) {
      Fluttertoast.showToast(
          msg:
              'Enter a valid phone number. ex- +91 1234567899, 123456789, etc.');
      return false;
    } 
    else
      return true;
  }
  return false;
}

/*else if (!isContactNumberValid && college==null) {
                      Fluttertoast.showToast(
                        msg: 'Enter valid phone number and your college',
                      );
                    } else if (!isContactNumberValid) {
                      Fluttertoast.showToast(
                        msg: 'Enter valid phone number',
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Enter your college',
                      );
                    }*/
