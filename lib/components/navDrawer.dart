import 'package:EffeCA/components/navdrawerItem.dart';
import 'package:EffeCA/screens/about.dart';
import 'package:EffeCA/screens/contact.dart';
import 'package:EffeCA/screens/developerinfo.dart';
import 'package:EffeCA/screens/eventscreen.dart';
import 'package:EffeCA/screens/leaderboard.dart';
import 'package:EffeCA/screens/message.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../screens/firstscreen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    Key key,
    @required this.userLoad,
  }) : super(key: key);

  final User userLoad;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(userLoad?.name ?? ' '),
          accountEmail: Text(userLoad?.email ?? ' '),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
            child: Image(image: NetworkImage(userLoad?.imageURL ?? '')),
          ),
        ),
        NavItem(
          title: 'Home',
          iconData: Icons.home,
          onPressed: () {
            Navigator.pop(context);
            Navigator.popUntil(context, ModalRoute.withName('/'));
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => FirstScreen(),
                ),
              );
          },
        ),
        NavItem(
            title: 'Events',
            iconData: Icons.event,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => EventScreen(),
                ),
              );
            }),
        NavItem(
            title: 'Leaderboard',
            iconData: Icons.group,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => LeaderboardScreen(),
                ),
              );
            }),
        NavItem(
            title: 'About',
            iconData: Icons.info_outline,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => AboutScreen()),
              );
            }),
        NavItem(
            title: 'Message',
            iconData: Icons.message,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => MessageScreen()),
              );
            }),
        NavItem(
            title: 'Developer Info',
            iconData: Icons.info,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => DevInfoScreen()),
              );
            }),
        NavItem(
            title: 'Contact',
            iconData: Icons.call,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => ContactScreen()),
              );
            })
      ],
    ));
  }
}
