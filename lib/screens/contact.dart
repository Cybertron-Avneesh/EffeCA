import 'dart:convert';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navigationDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EffeCA/components/drawer.dart';

import '../Utils/constants.dart';

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<void> _sendEmail(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ContactScreen extends DrawerContent {
  static const String id = 'contact_screen';
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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

    Future<bool> _onBackPress() {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>MainWidget()));
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
          title: Text('Contacts'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: null)
            // Add Logout Feature
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: kBgGradient,
            ),
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height:5,
              ),
              Center(
                child: RaisedButton(
                  splashColor: kShadow,
                  child: Text(
                    "Email: effervescence@iiita.ac.in",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: ()=>_sendEmail("mailto:effervescence@iiita.ac.in"),
                  elevation: 1,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height:10,
              ),
              Center(
                child: Text(
                  "App Related Issue",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height:20,
              ),
              ContactDrawer(name: "Ritik Harchani",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Avneesh Kumar",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Karan Kunwar",phoneNo: "7908175902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Ananya",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Tejas",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Any Other Issue",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height:20,
              ),
              ContactDrawer(name: "Ritik Harchani",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Avneesh Kumar",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Karan Kunwar",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Ananya",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Tejas",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Avneesh Kumar",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Karan Kunwar",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
              ContactDrawer(name: "Ananya",phoneNo: "7908195902",email: "karankunwar59@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactDrawer extends StatefulWidget {
  ContactDrawer({this.name,this.phoneNo,this.email});
  final name;
  final phoneNo;
  final email;
  @override
  _ContactDrawerState createState() => _ContactDrawerState();
}

class _ContactDrawerState extends State<ContactDrawer> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            widget.name,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 40),
          child: Row(
            children:<Widget>[
              IconButton(
                splashColor: Colors.redAccent,
                icon: Icon(
                  EvaIcons.email,
                  color: Colors.red,
                ),
                onPressed: (){
                  _sendEmail('mailto:${widget.email}');
                },
              ),
              IconButton(
                splashColor: Colors.lightBlueAccent,
                icon: Icon(
                  EvaIcons.phone,
                  color: Colors.blue,
                ),
                onPressed: (){
                  _makePhoneCall('tel:${widget.phoneNo}');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
