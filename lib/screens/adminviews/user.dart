import 'package:flutter/material.dart';

class AdminUser extends StatefulWidget {
  AdminUser({Key key}) : super(key: key);

  @override
  _AdminUserState createState() => _AdminUserState();
}

class _AdminUserState extends State<AdminUser> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Center(
         child: Text ("User"),
       ),
    );
  }
}