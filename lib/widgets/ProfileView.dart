import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import '../widgets/PostsView.dart';

class ProfileView extends StatefulWidget {
  final String token;
  final int id;
  ProfileView(this.token, this.id);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
     return FutureBuilder<http.Response>(
        future: fetchProfile(widget.token, widget.id),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var account = json.decode(snapshot.data.body);
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10),),
                  Center(
                    child: Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(account['profile_image_url']),
                          fit: BoxFit.fill,
                        )
                      ),
                    ),
                  ),
                  Text(account['email'].replaceAll('@utrgv.edu', '')),
                  Padding(padding: EdgeInsets.all(10),),
                  Text(account['bio']),
                  Divider(),
                  Container(
                    child: Expanded(child: PostsView(widget.token, id:widget.id),)
                  ),
                ],
              ),
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