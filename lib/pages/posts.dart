import 'package:flutter/material.dart';
import '../widgets/PostsView.dart';

class Posts extends StatefulWidget {
  final String token;
  Posts(this.token);
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: PostsView(widget.token),)
    );
  }
}