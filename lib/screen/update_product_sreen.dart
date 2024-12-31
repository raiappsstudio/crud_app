import 'dart:convert';
import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpadeProductSreen extends StatefulWidget {
  UpadeProductSreen({super.key, required this.product});

  final Product product;

  static const String name = '/update-product';

  @override
  State<UpadeProductSreen> createState() => _UpadeProductSreenState();
}

class _UpadeProductSreenState extends State<UpadeProductSreen> {
  final TextEditingController _nameTDcontroller = TextEditingController();
  final TextEditingController _priceTDcontroller = TextEditingController();
  final TextEditingController _totalPriceTDcontroller = TextEditingController();
  final TextEditingController _quantityTDcontroller = TextEditingController();
  final TextEditingController _imageTDcontroller = TextEditingController();
  final TextEditingController _codeTDcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTDcontroller.text = widget.product.ProductName ?? '';
    _priceTDcontroller.text = widget.product.UnitPrice ?? '';
    _totalPriceTDcontroller.text = widget.product.TotalPrice ?? '';
    _quantityTDcontroller.text = widget.product.Qty ?? '';
    _imageTDcontroller.text = widget.product.Img ?? '';
    _codeTDcontroller.text = widget.product.ProductCode ?? '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
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
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Product name",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Name";
                }
                return null;
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _priceTDcontroller,
              decoration: InputDecoration(
                hintText: "Price",
                labelText: "Product Price",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product price";
                }
                return null;
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _totalPriceTDcontroller,
              decoration: InputDecoration(
                hintText: "Price",
                labelText: "Total Price",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Name";
                }
                return null;
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _quantityTDcontroller,
              decoration: InputDecoration(
                hintText: "Quantity",
                labelText: "Product Quantity",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Quantity";
                }
                return null;
              }),
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _codeTDcontroller,
              decoration: InputDecoration(
                hintText: "Code",
                labelText: "Product Code",
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "enter Product Code";
                }
                return null;
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
                return null;
              }),
          SizedBox(
            height: 16,
          ),
          Visibility(
            visible: _updateProductInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateProduct();
                  }
                },
                child: Text("Update Product")),
          )
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

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

    print(response.statusCode);
    print(response.body);

    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product has been updated")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product Not updated")));
    }
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
