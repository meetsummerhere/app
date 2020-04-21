import 'dart:convert';
import 'package:ORANGE/modal/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TambahProduk extends StatefulWidget {
  @override
  _TambahProdukState createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  String namaProduk, qty, harga, idUsers;
  final _key = new GlobalKey<FormState>();

  getPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getString("id");
    });
  }

  check(){
    final form =_key.currentState;
    if (form.validate()){
      form.save();
      submit();
    }
  }

submit()async{
final response =await http.post(
  BaseUrl.tambahProduk, body : {
"namaProduk" : namaProduk,
"qty" : qty,
"harga" : harga,
"idUsers" : idUsers
});
final data = jsonDecode(response.body);
int value = data['value'];
String pesan = data['message'];
if(value==1){
  print(pesan);
  setState(() {
    Navigator.pop(context);
  });
}else{
  print(print);
}
}

@override
  void initState() {
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
        
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              onSaved: (e) => namaProduk = e,
              decoration: InputDecoration(labelText: "Nama Produk", labelStyle: TextStyle(color:Colors.green)
              ),
            ),
            TextFormField(
              onSaved: (e) => qty = e,
              decoration: InputDecoration(labelText: "Qty", labelStyle: TextStyle(color:Colors.green)
              ),
            ),
            TextFormField(
              onSaved: (e) => harga = e,
              decoration: InputDecoration(labelText: "Harga", labelStyle: TextStyle(color:Colors.green)
              ),
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
