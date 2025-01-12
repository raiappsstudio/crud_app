import 'dart:convert';
import 'package:crud_app/models/product.dart';
import 'package:crud_app/screen/add_new_product_sreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productlist = [];
  bool _getProductlistInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                _getProductList();
              },
              icon: Icon(Icons.refresh))
        ],
      ),

      //this is swip refreshment method
      body: RefreshIndicator(
        onRefresh: () async {
          _getProductList();
        },
        //visibility is proggress ber=======================
        child: Visibility(
          visible: _getProductlistInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: productlist.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: productlist[index],
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductSreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }




//json request method==================================
  Future<void> _getProductList() async {
    _getProductlistInProgress = true;
    setState(() {});
    productlist.clear();
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(uri);
/*    print(response.statusCode);
    print(response.body);*/

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      for (Map<String, dynamic> p in decodeData['data']) {
        Product product = Product(
          id: p['_id'],
          ProductName: p['ProductName'],
          ProductCode: p['ProductCode'],
          Img: p['Img'],
          UnitPrice: p['UnitPrice'],
          Qty: p['Qty'],
          TotalPrice: p['TotalPrice'],
          CreatedDate: p['CreatedDate'],
        );

        productlist.add(product);
      }
      setState(() {});
    }
    _getProductlistInProgress = false;
    setState(() {});
  }
}
