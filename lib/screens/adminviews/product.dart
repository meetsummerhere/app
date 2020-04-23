import 'dart:convert';

import 'package:ORANGE/modal/api.dart';
import 'package:ORANGE/modal/produkModel.dart';
import 'package:ORANGE/screens/adminviews/editProduk.dart';
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
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.lihatProduk);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
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

  dialogDelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Text("Apakah Kamu yakin ingin menghapus Produk ini ?", 
                style: TextStyle(fontSize:18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                   InkWell(
                     onTap: (){
                        Navigator.pop(context);
                     },
                    child:Text("No")),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      onTap:(){
                        _delete(id);
                      },
                     child: Text("Yes")),
                  ],
                ),
              ],
            ),
          );
        });
  }

  _delete(String id) async {
    final response =
        await http.post(BaseUrl.deleteProduk, body: {"idProduk": id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
        _lihatData();
      });
    } else {
      print(pesan);
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TambahProduk(_lihatData)));
        },
      ),
      body: RefreshIndicator(
        onRefresh: _lihatData,
        key: _refresh,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
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
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditProduk(x, _lihatData)));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            dialogDelete(x.id);
                          },
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
