import 'package:flutter/material.dart';
import '../widgets/AccountView.dart';

class Account extends StatefulWidget {
  final String token;
  Account(this.token);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: AccountView(widget.token),)
    );
  }
}