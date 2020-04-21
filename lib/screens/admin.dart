import 'package:ORANGE/screens/adminviews/home.dart';
import 'package:ORANGE/screens/adminviews/product.dart';
import 'package:ORANGE/screens/adminviews/profil.dart';
import 'package:ORANGE/screens/adminviews/user.dart';
import 'package:flutter/material.dart';

class MenuAdmin extends StatefulWidget {
  final VoidCallback signOut;
  MenuAdmin (this.signOut);
  @override
  _MenuAdminState createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
             onPressed: (){
            setState(() {
              widget.signOut();
            });
             },
            icon: Icon(Icons.lock_open),
            ),
        ],
      ),
      body: TabBarView(
        children: <Widget>[
            AdminHome(),
            AdminProduct(),
            AdminUser(),
            AdminProfil(),

        ],
        ),
          bottomNavigationBar: TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            indicator: UnderlineTabIndicator(
              borderSide:BorderSide(
                style: BorderStyle.none
              ),
            ),
            tabs:<Widget>[
                Tab(
                    icon: Icon(Icons.home),
                    text: "Home",
                ),
                Tab(
                    icon: Icon(Icons.apps),
                    text: "product",
                ),
                Tab(
                    icon: Icon(Icons.group),
                    text: "Users",
                ),
                Tab(
                    icon: Icon(Icons.account_circle),
                    text: "Profil",
                ),
                
            ],
             ),
             ),
    );
  }
}