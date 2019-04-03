import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as ta;

class CommentItem extends StatefulWidget {
  final String token;
  final Map comment;
  CommentItem(this.token, this.comment);
  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {

  String getTimeAgo(String postTime){
    Duration dur = DateTime.now().difference(DateTime.parse(postTime));
    var timeago = DateTime.now().subtract(dur);
    return ta.format(timeago);
  }

  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.only(bottom: 10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           Row(
              children: <Widget>[
              Padding(padding: EdgeInsets.all(3),),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.comment['user']['profile_image_url']),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              Padding(padding: EdgeInsets.all(3),),
              Text(widget.comment['user']['email'].replaceAll('@utrgv.edu', ''),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
              ],
           ),
           Padding(
             padding: const EdgeInsets.only(left:50),
             child: Text(widget.comment['text']),
           ),
           Padding(
             padding: const EdgeInsets.only(left:50),
             child: Text(
              getTimeAgo(widget.comment['created_at']),
              style:TextStyle(color:Colors.grey, fontSize: 12)
            ),
           ), 
           Divider()
         ],
       ),
     );
  }
}