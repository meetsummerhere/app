import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ORANGE/providers/app_provider.dart';
import 'package:ORANGE/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "",
      nama = "",
      email = "",
      phone = "",
      alamat = "",
      gender = "",
      t_lahir = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      nama = preferences.getString("nama");
      email = preferences.getString("email");
      phone = preferences.getString("phone");
      alamat = preferences.getString("alamat");
      gender = preferences.getString("gender");
      t_lahir = preferences.getString("t_lahir");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Image.asset(
                    "assets/images/orange.png",
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "$username",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "$email",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20.0),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     InkWell(
                      //       onTap: () {
                      //         Navigator.of(context).pushReplacement(
                      //           MaterialPageRoute(
                      //             builder: (BuildContext context) {
                      //               return LoginScreen();
                      //             },
                      //           ),
                      //         );
                      //       },
                      //       child: Text(
                      //         "Logout",
                      //         style: TextStyle(
                      //           fontSize: 13.0,
                      //           fontWeight: FontWeight.w400,
                      //           color: Theme.of(context).accentColor,
                      //         ),
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Account Information".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$nama",
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: () {},
                tooltip: "Edit",
              ),
            ),
            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$email",
              ),
            ),
            ListTile(
              title: Text(
                "Phone",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$phone",
              ),
            ),
            ListTile(
              title: Text(
                "Address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$alamat",
              ),
            ),
            ListTile(
              title: Text(
                "Gender",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$gender",
              ),
            ),
            ListTile(
              title: Text(
                "Date of Birth",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                "$t_lahir",
              ),
            ),
            ListTile(
              title: Text(
                "Dark Theme",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Switch(
                value: Provider.of<AppProvider>(context).theme ==
                        Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async {
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.lightTheme, "light");
                  }
                },
                activeColor: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
