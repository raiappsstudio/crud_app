import 'package:crud_app/models/product.dart';
import 'package:crud_app/screen/add_new_product_sreen.dart';
import 'package:crud_app/screen/product_list_screen.dart';
import 'package:crud_app/screen/update_product_sreen.dart';
import 'package:flutter/material.dart';

class SCUD extends StatelessWidget {
  const SCUD({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // home: ProductListScreen(),
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = const ProductListScreen();
        } else if (settings.name == AddNewProductSreen.name) {
          widget =  AddNewProductSreen();
        } else if (settings.name == UpadeProductSreen.name) {
          final Product product = settings.arguments as Product;
          widget = UpadeProductSreen(product: product);
        }

        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}