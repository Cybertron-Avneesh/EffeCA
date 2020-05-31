import 'dart:convert';
import 'package:EffeCA/components/drawer.dart';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:EffeCA/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';


final _firestoreLBDetail = Firestore.instance.collection('Leaderboard');

class FirstScreen extends DrawerContent {
  static const String id = 'first_screen';
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  User userLoad = new User();
  Animation animation;
  AnimationController controller;

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
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),

    );


    animation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);


    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
   var ScreenSize = MediaQuery.of(context).size;
   //Add app url
   String appUrl='';
    return  Scaffold(

            appBar: AppBar(
             backgroundColor: kSkin,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: widget.onMenuPressed,
              ),
              title: Text('Home'),

            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: kBgGradient,
                ),
              ),
            padding: EdgeInsets.only(top: 30),
              alignment: Alignment.topCenter,
              child: Column(
                children:<Widget> [
                  Text(

                    'Hi ${userLoad.name},',
                    style: TextStyle(color: Color(0xff383637), fontSize: 30,
                    fontWeight: FontWeight.w900),
                  ),
                  Text(
                    'Glad to have you as our campus ambassador ;)',
                    style: TextStyle(
                      color: Color(0xff383637),
                      fontSize: 17
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(alignment: Alignment.center, children: <Widget>[
                      SvgPicture.asset('assets/Rank.svg',
                      ),

                      Positioned(
                        top: ScreenSize.height/12,
                        child: StreamBuilder(
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
                              style: TextStyle(color: Color(0xf1D4AF37),
                                  fontSize: animation.value*120,
                              fontWeight: FontWeight.w900),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),

                  GestureDetector(
                    onTap:(){ Share.share('Hey, check out the Effervescence \'20 CA App \n $appUrl' );},
                    child: Card(
                      elevation: 7,

                      margin: EdgeInsets.only(bottom: 50,right: 20,left: 20,top: 40),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Color(0xff383637),

                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Refer the Campus Ambassador app to your friends.',
                              style: TextStyle(
                                color: Color(0xffDF2AFF),
                                fontSize: 15,
                                fontWeight: FontWeight.w300

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Let them know about the Campus Ambassador Program!',
                              style: TextStyle(
                                  color: Color(0xffDF2AFF),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,


                              ),


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.blue,
                                  ),
                                ),

                                Container(
                                  width: 2*(ScreenSize.width)/3,
                                  child: Text(
                                    'Share this app with your friends',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,

                                    ),
                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),


                    ),
                  ),
                ],
              ),
            ),
    );
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
