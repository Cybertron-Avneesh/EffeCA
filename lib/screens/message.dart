import 'dart:convert';
import 'package:EffeCA/components/drawer.dart';
import 'package:EffeCA/Utils/constants.dart';
import 'package:EffeCA/Utils/shared_preference_helper.dart';
import 'package:EffeCA/model/user.dart';
import 'package:flutter/material.dart';
import 'package:EffeCA/components/navigationDrawer.dart';

class MessageScreen extends DrawerContent {
  static const String id = 'message_screen';
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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
          title: Text('Message'),
          ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
                    child: RichText(
              softWrap: true,
              textAlign: TextAlign.left,

                text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Message to all Campus Ambassadors\n',
                style: TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
              TextSpan(
                  text: '\nGreetings Ambassadors,\n', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
              TextSpan(
                text:
                    '\nWe are pleased to announce that the campus ambassador app is ready and deployed. This app will be used by all the campus ambassadors, so that all of you can keep us informed regarding your progress as campus ambassadors.' +
                    '\nFollowing are the rules and guidelines pertaining to the app, which have to be taken care of:' +
                    '\n1. You are supposed to log in using your valid email or gmail account'  +
                    '\n2. In case you opt for logging in via email, you need to manually verify your email address.' +
                    '\n3. After logging in, you will be taken to the dashboard, where there will be tasks set by the organising committee' +
                    '\n4. After the tasks are set, you have to start sharing the posts, the links to which you can find with the task itself.' +
                    '\n5. You will upload the screenshots of your sharing by clicking the upload button given in the page. This will increase your score.' +
                    '\n6. The Leaderboard is located in the left menu, showing where you stand against other campus ambassadors.' +
                    '\n7. The works of the all campus ambassadors will be manually monitored by our developer team, so kindly refrain from any malpractices. Defaulters will have to face immediate disqualification and their account will be banned.' +
                    '\nThus, we request you to kindly abide by the above rules and help making this edition of Effervescence a grand success. Lots of perks await for the campus ambassador who prevails. We wish you all the luck, and hope that you carry out your responsibilities with the best of your abilities, and help us in making this festival a grand success.' +
                    '\n\nThanks and regards,' +
                    '\nTeam Effervescence',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey))
            ])),
          ),
        ),
      ),
    );
  }
}

/*


Greetings Ambassadors,

We are pleased to announce that the campus ambassador app is ready and deployed. This app will be used by all the campus ambassadors, so that all of you can keep us informed regarding your progress as campus ambassadors.

Following are the rules and guidelines pertaining to the app, which have to be taken care of:

1. You are supposed to log in using your valid email or gmail account

2. In case you opt for logging in via email, you need to manually verify your email address.

3. After logging in, you will be taken to the dashboard, where there will be tasks set by the organising committee

4. After the tasks are set, you have to start sharing the posts, the links to which you can find with the task itself.

5. You will upload the screenshots of your sharing by clicking the upload button given in the page. This will increase your score.

6. The Leaderboard is located in the left menu, showing where you stand against other campus ambassadors.

7. The works of the all campus ambassadors will be manually monitored by our developer team, so kindly refrain from any malpractices. Defaulters will have to face immediate disqualification and their account will be banned.

Thus, we request you to kindly abide by the above rules and help making this edition of Effervescence a grand success. Lots of perks await for the campus ambassador who prevails. We wish you all the luck, and hope that you carry out your responsibilities with the best of your abilities, and help us in making this festival a grand success.

Thanks and regards, Team Effervescence

*/
