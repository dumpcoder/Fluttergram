import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as ta;
import '../utilities/requests.dart';
import '../pages/comments.dart';
import '../pages/likes.dart';
import '../pages/profile.dart';

class PostItem extends StatefulWidget {
  final Map post;
  final String token;
  final Function refresh;
  final bool profile;
  PostItem(this.post, this.token, this.refresh, {this.profile: false});
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool like = false; 

  handleLike(){
    likePost(widget.token, widget.post['id'], widget.post['liked']);
    widget.refresh();
  }

  handleComment(){
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Comments(widget.token, widget.post['id'])),
      );
  }

  handleLikes(){
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Likes(widget.token, widget.post['id'])),
      );
  }

   handleProfile(){
     if(!widget.profile){
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile(widget.token, widget.post['user_id'])),
      );
    }
  }

  String commentMessage(int count){
    if(count == 0)
      return "";
    else if(count == 1)
      return "View $count comment";
    
    return "View all $count comments";
  }

  String getTimeAgo(String postTime){
    Duration dur = DateTime.now().difference(DateTime.parse(postTime));
    var timeago = DateTime.now().subtract(dur);
    return ta.format(timeago);
  }

  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.only(top:25, bottom: 25),
    
      //User
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: handleProfile,
              child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(3),),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.post['user_profile_image_url']),
                      fit: BoxFit.fill,
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.all(3),),
                Text(widget.post['user_email'].replaceAll('@utrgv.edu', ''))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(3),),
          //Image
          GestureDetector(
            onDoubleTap: handleLike,
             child: FadeInImage(
               placeholder: AssetImage('assets/placeholder.gif'),
               image: NetworkImage(widget.post['image_url']),
            )
          ),
          // Action Bar
          Row(
            children: <Widget>[
              IconButton(
                icon: widget.post['liked'] ? Icon(Icons.favorite, color: Colors.red, size: 30,) : Icon(Icons.favorite_border, size: 30,),
                onPressed: handleLike,
              ),
              IconButton(
                icon: Icon(Icons.comment,color:Colors.black, size: 30),
                onPressed: handleComment,
              )
            ],
          ),
          Divider(),
          //Caption
          GestureDetector(
              onTap: handleLikes,
              child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite),
                ),
                Text("${widget.post['likes_count']} likes"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post['caption']),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: handleComment,
                      child: Text(
                        "${commentMessage(widget.post['comments_count'])}",
                        style:TextStyle(color: Colors.grey)
                        ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTimeAgo(widget.post['created_at']),
                       style:TextStyle(color:Colors.grey, fontSize: 12)
                       )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}