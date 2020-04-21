import 'package:ORANGE/screens/adminviews/tambahProduk.dart';
import 'package:flutter/material.dart';

class AdminProduct extends StatefulWidget {
  AdminProduct({Key key}) : super(key: key);

  @override
  _AdminProductState createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TambahProduk()));
        },
        ),
       body: Center(
         child: Text ("Product"),
       ),
    );
  }
}