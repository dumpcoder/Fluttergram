import 'package:flutter/material.dart';
import '../widgets/LikesView.dart';

class Likes extends StatefulWidget {
  final String token;
  final int id;
  Likes(this.token, this.id);
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
      ),
      body: LikesView(widget.token, widget.id),
    );
  }
}