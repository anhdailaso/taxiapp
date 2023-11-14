import 'package:flutter/material.dart';

class HomeMeu extends StatefulWidget {
  const HomeMeu({super.key});

  @override
  State<HomeMeu> createState() => _HomeMeuState();
}

class _HomeMeuState extends State<HomeMeu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset("assets/ic_menu_user.png"),
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_history.png"),
          title: Text(
            "Ride History",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_percent.png"),
          title: Text(
            "Offers",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_notify.png"),
          title: Text(
            "Notifications",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_help.png"),
          title: Text(
            "Help & Supports",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_logout.png"),
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 18, color: Color(0xff323643)),
          ),
        ),
      ],
    );
  }
}
