import 'package:flutter/material.dart';
import '../widgets/ProfileView.dart';

class Profile extends StatefulWidget {
  final String token;
  final int id;
  Profile(this.token, this.id);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fluttergram",
          style: TextStyle(
            color:Colors.white, 
            fontSize: 33,
            fontFamily: "Satisfy",
          ),
        ),
        centerTitle: true,
      ),
      body: ProfileView(widget.token, widget.id),
    );
  }
}