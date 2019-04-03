import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:timeago/timeago.dart' as ta;

class LikeItem extends StatefulWidget {
  final String token;
  final Map like;
  LikeItem(this.token, this.like);
  @override
  _LikeItemState createState() => _LikeItemState();
}

class _LikeItemState extends State<LikeItem> {

  String getTimeAgo(String postTime){
    Duration dur = DateTime.now().difference(DateTime.parse(postTime));
    var timeago = DateTime.now().subtract(dur);
    return ta.format(timeago);
  }

  @override
  Widget build(BuildContext context) {
     return Container(
       child: Column(
         //crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Padding(padding: EdgeInsets.all(10)),
           FutureBuilder<http.Response>(
             future: fetchProfile(widget.token, widget.like['user_id']),
             builder: (context, snapshot){
               if(snapshot.hasData){
                 var profile = json.decode(snapshot.data.body);
                 return Row(
                   children: <Widget>[
                    Padding(padding: EdgeInsets.all(3),),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(profile['profile_image_url']),
                          fit: BoxFit.fill,
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3),),
                    Text(profile['email'].replaceAll('@utrgv.edu', ''))
                   ],
                 );
               }
              else if(snapshot.hasError){
                return Text("${snapshot.data.body}");
              }
              return JumpingDotsProgressIndicator(fontSize: 40,);
             }
           ),
           Divider()
         ],
       ),
     );
  }
}