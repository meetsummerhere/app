import 'dart:convert';

import 'package:ORANGE/modal/api.dart';
import 'package:ORANGE/modal/produkModel.dart';
import 'package:ORANGE/screens/adminviews/tambahProduk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminProduct extends StatefulWidget {

  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
var loading = false;
final list = new List<ProdukModel>();
_lihatData()async{
  list.clear();
  setState(() {
    loading = true;
  });
  final response = await http.get(BaseUrl.lihatProduk);
  if (response.contentLength == 2) {
  } else {
    final data = jsonDecode(response.body);
    data.forEach((api){
      final ab = new ProdukModel(
        api['id'],
        api['namaProduk'],
        api['qty'],
        api['harga'],
        api['createdDate'],
        api['idUsers'],
        api['nama'],
      );
      list.add(ab);
    });
  setState(() {
    loading = false;
  });
  }
}

@override
  void initState() {
    super.initState();
    _lihatData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TambahProduk()));
        },
        ),
       body: loading 
       ? Center(child: CircularProgressIndicator()) 
       : ListView.builder(
         itemCount: list.length,
         itemBuilder:  (context, i){
           final x = list[i];
           return Container(
             padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(x.namaProduk),
                  Text(x.qty),
                  Text(x.harga),
                  Text(x.nama),
                  Text(x.createdDate),
                ],
            ),
           );
         },
         ),
    );
  }
}