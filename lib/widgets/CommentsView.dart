import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'CommentItem.dart';

class CommentsView extends StatefulWidget {
  final String token;
  final int id;
  CommentsView(this.token, this.id);
  @override
  _CommentsViewState createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<http.Response>(
        future: fetchComments(widget.token, widget.id),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var comments = json.decode(snapshot.data.body);
            if(comments.length == 0)
              return Center(child: Text("No Comments"),);
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, position){
                return CommentItem(widget.token, comments[position]);
              },
            );
          }
          else if(snapshot.hasError){
            return Text("${snapshot.data.body}");
          }
          return JumpingDotsProgressIndicator(fontSize: 40,);
        },
      );
  }
}