import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'PostsView.dart';
import '../pages/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AccountView extends StatefulWidget {
  final String token;
  AccountView(this.token);
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  var ctr = TextEditingController();

   logout(){
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()),
    );
  }

  updateProfileImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    patchProfileImage(widget.token, image);
    setState(() {
      
    });
  }

  updateBio(String bio){
    if(bio != '' || bio != null){
      patchBio(widget.token, bio);
    }

    setState(() {
      ctr.clear(); 
    });
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<http.Response>(
        future: fetchAccount(widget.token),
        builder: (context, snapshot){
          if (snapshot.hasData){
            var account = json.decode(snapshot.data.body);
            return Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: updateProfileImage,
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
                  TextField(
                    controller: ctr,
                    onSubmitted: updateBio,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: account['bio'],
                      border: InputBorder.none
                    ),
                  ),
                  RaisedButton(
                    child: Text('Logout'),
                    onPressed: logout,
                    color: Colors.red,
                  ),
                  Divider(),
                  Container(
                    child: Expanded(child:PostsView(widget.token, id:account['id'])),
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