import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utilities/requests.dart';

class CreatePost extends StatefulWidget {
  final String token;
  final GlobalKey<ScaffoldState> scaffoldKey;
  CreatePost(this.token, this.scaffoldKey);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var file;
  String caption;
  
  updateCaption(String value) => caption = value;

  sendPost(){
    postPost(widget.token, file, caption);
    setState(() {
     file = null;
     widget.scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3), 
        content: Text("Post Created")
      )); 
    });

    
  }

  getImage({bool camera = false}) async{
    var image;
    if(camera)
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    else
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = image; 
    });   
  }

  eraseImage(){
    setState(() {
      file = null; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:50),
        child: file == null? ImageOptions(getImage) :Container(
          child: Column(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete_forever, color: Colors.red),
                onPressed: eraseImage,
              ),
              Image.file(file),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                onChanged: updateCaption,
                decoration: InputDecoration(
                  hintText: "Write a Caption",
                  suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: sendPost,
                    )
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }

}

class ImageOptions extends StatelessWidget {
  final Function getImage;
  ImageOptions(this.getImage);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: ()=> getImage(camera: true),
                child: Container(
                  alignment: Alignment(0, 0),
                  color: Colors.redAccent,
                  child: Icon(Icons.camera_alt, size: 300),
                ),
              ),
            ),
            Divider(),
            Center(
              child: GestureDetector(
                onTap: getImage,
                child: Container(
                  alignment: Alignment(0, 0),
                  color: Colors.blueAccent,
                  child: Icon(Icons.image, size: 300),
                ),
              ),
            )
          ],
        ),
    );
  }
}