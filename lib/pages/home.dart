import 'package:flutter/material.dart';
import 'posts.dart';
import 'create.dart';
import 'account.dart';

class Home extends StatefulWidget {
  final String token;
  Home(this.token);
  @override
  _HomeState createState() => _HomeState(token);
}

class _HomeState extends State<Home> {
  final Key scaffoldKey = GlobalKey<ScaffoldState>();
  int currentTab;
  List<Widget> tabs;
  String token;

  _HomeState(this.token){
    currentTab = 1;
    tabs =[
      CreatePost(token, scaffoldKey),
      Posts(token),
      Account(token),
    ];
  }

  changeTab(int tabIndex){
    setState(() {
     currentTab = tabIndex; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Fluttergram",
          style: TextStyle(
            color:Colors.black, 
            fontSize: 33,
            fontFamily: "Satisfy",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: tabs[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: changeTab,
        items: [
          BottomNavigationBarItem(
            title: Container(height: 0.0,),
            icon: Icon(Icons.linked_camera, size: 28,)
          ),
          BottomNavigationBarItem(
            title: Container(height: 0.0,),
            icon: Icon(Icons.home,  size: 28,),
          ),
          BottomNavigationBarItem(
            title: Container(height: 0.0,),
            icon: Icon(Icons.person,  size: 28,),
          ),
        ],
      ),
    );
  }
}