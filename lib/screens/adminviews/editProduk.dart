import 'dart:convert';

import 'package:ORANGE/modal/api.dart';
import 'package:ORANGE/modal/produkModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduk extends StatefulWidget {
  final ProdukModel model;
  final VoidCallback reload;
  EditProduk(this.model, this.reload);

  @override
  _EditProdukState createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final _key = new GlobalKey<FormState>();
  String namaProduk, qty, harga;
  TextEditingController txtNama, txtQty, txtHarga;

  setup() {
    txtNama = TextEditingController(text: widget.model.namaProduk);
    txtQty = TextEditingController(text: widget.model.qty);
    txtHarga = TextEditingController(text: widget.model.harga);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    final response = await http.post(BaseUrl.editProduk, body: {
      "namaProduk" : namaProduk,
      "qty" : qty,
      "harga" : harga,
      "idProduk" : widget.model.id

    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data ['message'];

    if (value == 1) {
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }

  }

@override
  void initState() {
    super.initState();
    setup();
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
              controller: txtNama,
              onSaved: (e) => namaProduk = e,
              decoration: InputDecoration(
                  labelText: "Nama Produk",
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: txtQty,
              onSaved: (e) => qty = e,
              decoration: InputDecoration(
                  labelText: "Qty", labelStyle: TextStyle(color: Colors.black)),
            ),
            TextFormField(
              controller: txtHarga,
              onSaved: (e) => harga = e,
              decoration: InputDecoration(
                  labelText: "Harga",
                  labelStyle: TextStyle(color: Colors.black)),
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
