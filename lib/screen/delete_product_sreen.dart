import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/product.dart';

class DeleteProductSreen extends StatefulWidget {
  const DeleteProductSreen({super.key, required this.product});

  static const String name = '/delete-product';
  final Product product;

  @override
  State<DeleteProductSreen> createState() => _DeleteProductSreenState();
}

class _DeleteProductSreenState extends State<DeleteProductSreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyalerDialog(context),
        ],
      ),
    );
  }



  //==========================================================
  Future<void> _deleteProduct() async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}');
    Object? requestBody;
    Response response = await post(uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode(requestBody));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Delete Success!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some Error"),
        ),
      );
    }
  } //_delete Method end here==========
}

MyalerDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
            child: AlertDialog(
          title: Text('this is Alert'),
          content: Text("Do you want to exit"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'))
          ],
        ));
      });
}
