import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'PostItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';

class PostsView extends StatefulWidget {
  final String token;
  final int id;
  PostsView(this.token, {this.id});
  @override
  _PostsViewState createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {

  refresh() async{
    setState(() {
      //refresh
    });
  }

  @override
  Widget build(BuildContext context) {
     return RefreshIndicator(
        onRefresh:()=> refresh(),
        //Gets post info
        child: FutureBuilder<http.Response>(
        future: widget.id != null ? fetchUserPosts(widget.token, widget.id):fetchPosts(widget.token),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var posts = json.decode(snapshot.data.body);
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, position){
                if(widget.id != null){
                  return PostItem(posts[position], widget.token, refresh, profile: true,);
                }
                return PostItem(posts[position], widget.token, refresh);
              },
            );
          }
          else if(snapshot.hasError){
            return Text("${snapshot.data.body}");
          }
          return JumpingDotsProgressIndicator(fontSize: 40,);
        },
      ),
    );
  }
}