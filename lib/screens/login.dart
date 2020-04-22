import 'dart:convert';

import 'package:ORANGE/modal/api.dart';
import 'package:ORANGE/screens/admin.dart';
import 'package:ORANGE/screens/main_screen.dart';
import 'package:ORANGE/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginStatus { notSignIn, signIn, signInAdmin }

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  final _key = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  login() async {
    final response = await http.post(BaseUrl.login,
        body: {"username": username, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['username'];
    String namaAPI = data['nama'];
    String emailAPI = data['email'];
    String phoneAPI = data['phone'];
    String alamatAPI = data['alamat'];
    String genderAPI = data['gender'];
    String t_lahirAPI = data['t_lahir'];
      String idAPI = data['id'];
    String level = data['level'];
    if (value == 1) {
      //cek level
      if (level == "1") {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(value, usernameAPI, namaAPI, emailAPI, phoneAPI, alamatAPI,
              genderAPI, t_lahirAPI, level, idAPI);
        });
      } else {
        setState(() {
          _loginStatus = LoginStatus.signInAdmin;
          savePref(value, usernameAPI, namaAPI, emailAPI, phoneAPI, alamatAPI,
              genderAPI, t_lahirAPI, level, idAPI);
        });
      }
      print(pesan);
    } else {
      print(pesan);
    }
  }

  savePref(int value, String username, String nama, String email, String phone,
      String alamat, String gender, String t_lahir, String level, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("nama", nama);
      preferences.setString("username", username);
      preferences.setString("email", email);
      preferences.setString("phone", phone);
      preferences.setString("alamat", alamat);
      preferences.setString("gender", gender);
      preferences.setString("t_lahir", t_lahir);
      preferences.setString("level", level);
      preferences.setString("id", id);

      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getString("level");

      _loginStatus = value == "1"
          ? LoginStatus.signIn
          : value == "2" ? LoginStatus.signInAdmin : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(
                   backgroundColor: Colors.transparent,
bottomOpacity: 0.0,
elevation: 0.0,
        automaticallyImplyLeading: false,
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                new Image.asset(
                  "assets/images/launcher.png",
                  width: 110.0,
                  height: 110.0,
                ),
                Text(
                  'ORANGE JUICE ',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 30.0),
                Card(
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please Insert Username";
                        }
                      },
                      onSaved: (e) => username = e,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Username",
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.0),
                Card(
                  elevation: 3.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: TextFormField(
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Please Insert Password";
                        }
                      },
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      obscureText: _secureText,
                      onSaved: (e) => password = e,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          color: Colors.green,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                // TextFormField(
                //             validator: (e) {
                //               if (e.isEmpty) {
                //                 return "Please Insert Password";
                //               }
                //             },
                //             obscureText: _secureText,
                //             onSaved: (e) => password = e,
                //             decoration: InputDecoration(
                //               labelText: "Password",
                //               suffixIcon: IconButton(
                //                 onPressed: showHide,
                //                 color: Colors.green,
                //                 icon: Icon(_secureText
                //                     ? Icons.visibility_off
                //                     : Icons.visibility),
                //               ),
                //             ),
                //             style: TextStyle(color: Colors.green),
                //           ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 25.0,
                  ),
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MainScreen()),
                    // );
                    check();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 25.0,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text(
                    'dont have an account ? Register Here !',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );

        break;
      case LoginStatus.signIn:
        return MainScreen(signOut);
        break;
      case LoginStatus.signInAdmin:
        return MenuAdmin(signOut);
        break;
    }
  }
}

// class MainScreen extends StatefulWidget {

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//     );
//   }
// }
