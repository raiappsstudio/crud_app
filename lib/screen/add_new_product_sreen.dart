import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductSreen extends StatefulWidget {
  AddNewProductSreen({super.key});

  static const String name = '/add-new-product';

  @override
  State<AddNewProductSreen> createState() => _AddNewProductSreenState();
}

class _AddNewProductSreenState extends State<AddNewProductSreen> {
  final TextEditingController _nameTDcontroller = TextEditingController();
  final TextEditingController _priceTDcontroller = TextEditingController();
  final TextEditingController _totalPriceTDcontroller = TextEditingController();
  final TextEditingController _quantityTDcontroller = TextEditingController();
  final TextEditingController _imageTDcontroller = TextEditingController();
  final TextEditingController _codeTDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addnewproductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildPRoductForm(),
        ),
      ),
    );
  }

  Widget _buildPRoductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameTDcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Product name",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Name";
                }
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _priceTDcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Price",
                labelText: "Product Price",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product price";
                }
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _totalPriceTDcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Price",
                labelText: "Total Price",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Name";
                }
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _quantityTDcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Quantity",
                labelText: "Product Quantity",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Quantity";
                }
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _codeTDcontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Code",
                labelText: "Product Code",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Code";
                }
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _imageTDcontroller,
              decoration: InputDecoration(
                hintText: "Image",
                labelText: "Product Image",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Image";
                }
              }),
          SizedBox(
            height: 16,
          ),
          Visibility(
            visible: _addnewproductInProgress == false,
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addNewProduct();
                  }
                },
                child: Text("Add Product")),
          )
        ],
      ),
    );
  }

//this method is post mathod=======================
  Future<void> _addNewProduct() async {
    _addnewproductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
    Map<String, dynamic> requestBody = {
      "ProductName": _nameTDcontroller.text.trim(),
      "ProductCode": _codeTDcontroller.text.trim(),
      "Img": _imageTDcontroller.text.trim(),
      "UnitPrice": _priceTDcontroller.text.trim(),
      "Qty": _quantityTDcontroller.text.trim(),
      "TotalPrice": _totalPriceTDcontroller.text.trim(),
    };

    Response response = await post(uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode(requestBody));
/*
    print(response.statusCode);
    print(response.body);*/

    _addnewproductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New Product Added"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some Error"),
        ),
      );
    }
  }

  void _clearTextField() {
    _nameTDcontroller.clear();
    _priceTDcontroller.clear();
    _totalPriceTDcontroller.clear();
    _quantityTDcontroller.clear();
    _imageTDcontroller.clear();
    _codeTDcontroller.clear();
    _nameTDcontroller.clear();
  }

  @override
  void dispose() {
    _nameTDcontroller.dispose();
    _priceTDcontroller.dispose();
    _totalPriceTDcontroller.dispose();
    _quantityTDcontroller.dispose();
    _imageTDcontroller.dispose();
    _codeTDcontroller.dispose();
    _nameTDcontroller.dispose();
    super.dispose();
  }
}
