import 'package:flutter/material.dart';
import '../utilities/requests.dart';
import 'home.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "tomas.torres01@utrgv.edu";
  String password = "20273278";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pCtr =TextEditingController();
  
  updateUsername(String value) => username = value;
  updatePassword(String value) => password = value;
  
  erasePassword(){
    setState(() {
     pCtr.clear();
     password = ""; 
    });
  }

  login(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2), 
        content:Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(padding: EdgeInsets.all(20),),
            Text("Signing-In...")
          ],
        ),
      ));

    handleLogin(username, password).then((response){
      if(response.statusCode == 200){
        var map =jsonDecode(response.body);
        String token = map['token'];
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(token)),
        );

      }
      else{
          _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3), 
        content: Text("Wrong username or password")
        ));
        erasePassword();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196f3), Color(0xFFf44336)],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Fluttergram",
              style: TextStyle(
                 color:Colors.white, 
                 fontSize: 33,
                 fontFamily: "Satisfy",
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "username",
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: updateUsername
                  ),
                  TextField(
                    controller: pCtr,
                decoration: InputDecoration(
                fillColor: Colors.white,
                border: InputBorder.none,
                labelText: "password",
                prefixIcon: Icon(Icons.lock_outline),
              ),
              onChanged: updatePassword,
              obscureText: true,
            ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('login', style: TextStyle(color: Colors.white),),
              color: Colors.blueAccent,
              onPressed: login,
            )
          ],
        ),
      )
    );
  }
}
