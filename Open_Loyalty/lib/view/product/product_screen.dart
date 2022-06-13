import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/view/product/components/body.dart';

import '../../models/product_model.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  initState() {
    super.initState();
    for (int i = 0; i < products.length; i++) {
        addProduct(i);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: subhead,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sản phẩm của bạn',
          style: TextStyle(
            fontSize: subhead,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
