import 'package:flutter/material.dart';
import '../widgets/CommentsView.dart';
import '../utilities/requests.dart';

class Comments extends StatefulWidget {
  final String token;
  final int id;
  Comments(this.token, this.id);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {

  String comment;
  final TextEditingController ctr =TextEditingController();

  updateComment(String value) => comment = value;
  sendComment(){
    if(comment != null && comment != ""){
      setState(() {
        commentPost(widget.token, widget.id, comment);
        ctr.clear();
        comment = null;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10),),
            TextField(
              controller: ctr,
              onChanged: updateComment,
              decoration: InputDecoration(
                hintText: "Write a Comment",
                suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: sendComment,
                  )
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Expanded(child:CommentsView(widget.token, widget.id)),
          ],
        ),
      )
    );
  }
}