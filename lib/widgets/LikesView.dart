import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'LikeItem.dart';

class LikesView extends StatefulWidget {
  final String token;
  final int id;
  LikesView(this.token, this.id);
  @override
  _LikesViewState createState() => _LikesViewState();
}

class _LikesViewState extends State<LikesView> {

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<http.Response>(
        future: fetchLikes(widget.token, widget.id),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var likes = json.decode(snapshot.data.body);
            if(likes.length == 0)
              return Center(child: Text("No Likes"),);
            return ListView.builder(
              itemCount: likes.length,
              itemBuilder: (context, position){
                return LikeItem(widget.token, likes[position]);
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