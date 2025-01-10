import 'dart:convert';

import 'package:crud_app/models/product.dart';
import 'package:crud_app/screen/delete_product_sreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../screen/update_product_sreen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}



class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        widget.product.Img ?? "",
        width: 60,
      ),
      title: Text(widget.product.ProductName ?? ""),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product code: ${widget.product.ProductCode ?? ""}"),
          Text("Quantity:${widget.product.Qty ?? ""}"),
          Text("Price: ${widget.product.UnitPrice ?? ""}"),
          Text("Total Price: ${widget.product.TotalPrice ?? ""}"),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: () {

            MyalerDialog(context);

          }, icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UpadeProductSreen.name,
                    arguments: widget.product);
              },
              icon: Icon(Icons.edit)),
        ],
      ),
    );
  }




  Future<void> _deleteProduct() async {
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${widget.product.id}');
    Object? requestBody;
    Response response = await get(uri,
        headers: {"Content-type": "application/json"},
      );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Delete Success!"),
        ),
      );

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some Error"),
        ),
      );

    }
      }//_delete Method end here==========


  MyalerDialog(context){

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Expanded(
              child: AlertDialog(
                title: Text('this is Alert'),
                content: Text("Do you want to exit"),
                actions: [
                  TextButton(onPressed: (){
                    _deleteProduct();
                    Navigator.of(context).pop();
                  },
                      child: Text('Yes')),

                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                      child: Text('No'))

                ],

              )
          );

        }

    );

  }//Alart dialog end here================



}






