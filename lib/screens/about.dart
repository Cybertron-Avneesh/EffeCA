import 'dart:convert';

import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/components/navDrawer.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Utils/constants.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        title: Text('About'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: null)
          // Add Logout Feature
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
                  Card(
                  margin: EdgeInsets.all(4),
                  elevation: 6,
                  child: Container(
                    color: Color(0xffbfe4ff),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'About CA Program',
                            style: TextStyle(color: Color(0xff030063), fontSize: 22.5 , fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 16.5),
                          Text(
                            Constants.AboutCAProgramDescription,
                            maxLines: 20,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16.5,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.5),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 220.0,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    ),
                  items: <Widget>[
                    HeadingIconCard(
                      icon: Icons.group_add,
                      heading: ' Participation',
                      content: Constants.ParticipationDesc,
                    ),
                    HeadingIconCard(
                      icon: Icons.public,
                      content: Constants.SocialMediaDesc,
                      heading: ' Social Media',
                    ),
                    HeadingIconCard(
                      icon: Icons.location_city,
                      content: Constants.MulticityDesc,
                      heading: ' Multicity'
                    ),
                  ],
              ),
              SizedBox(height: 12.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.redeem,
                    color: Color(0xff001173),
                  ),
                  Text(
                    ' Prizes and Incentives',
                     style: TextStyle(
                      color: Color(0xff001173),
                      fontSize: 22.5,
                      fontWeight: FontWeight.w700
                     ), 
                  ),
                ],
              ),
              SizedBox(height: 4.5),
              CarouselSlider(
                options: CarouselOptions(
                    height: 250.0,
                    enableInfiniteScroll: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                items: <Widget>[
                  ImageHolder(
                    image: 'assets/certificate.jpg',
                    caption: 'Certificate'
                  ),
                  ImageHolder(
                    image: 'assets/ticket.jpg',
                    caption: 'Pronite Tickets'
                  ),
                  ImageHolder(
                    image: 'assets/goodies.jpg',
                    caption: 'Amazing Goodies'
                  ),
                  ImageHolder(
                    image: 'assets/intern.jpg',
                    caption: 'Internship Opportunity'
                  ),
                ]
              ),
          ],
        ),
        ),
      );
  }
}

class ImageHolder extends StatelessWidget {
  const ImageHolder({@required this.image , @required this.caption});
  final String image;
  final String caption;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(image , height: 200),
              SizedBox(height: 5),
              Text(
                caption,
                style: TextStyle(
                  color: Color(0xff001173),
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeadingIconCard extends StatelessWidget {
  const HeadingIconCard({@required this.icon , @required this.heading , @required this.content});
  final IconData icon;
  final String heading;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        color: Color(0xffe8f3ff),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Color(0xff001173),
                    ),
                  Text(
                    heading,
                    style: TextStyle(color: Color(0xff001173) , fontSize: 22.5 , fontWeight: FontWeight.w700),
                  )
                ],
                ),
              SizedBox(height: 3.5),
              Text(
                content,
                style: TextStyle(
                  color: Color(0xff001173),
                  fontSize: 17.5,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
