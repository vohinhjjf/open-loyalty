import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/models/product_model.dart';
import 'package:open_loyalty/view/product/product_detail_screen.dart';
import 'package:open_loyalty/constant.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Body(),
    );
  }
}
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return productInfo(products[index]);
      },
    );
  }

  Widget productInfo(ProductModel product) {
    var name = product.productName;
    var purchaseDate = product.purchaseDate;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.fromLTRB(5, space_height, 5, 0),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 300,
          height: 184,
          padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: ListTile(
              leading: Image(
                image: AssetImage(product.image),
              ),
              title: Text(
                name,
                style:
                TextStyle(fontSize: footnote, fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: space_height * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ngày mua",
                        style: Constants.titleProductDetail,
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy").format(purchaseDate),
                        style: Constants.contentProductDetail,
                      )
                    ],
                  ),
                  SizedBox(
                    height: space_height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Giá",
                        style: Constants.titleProductDetail,
                      ),
                      Text(
                        formatNumber(product.price),
                        style: Constants.contentProductDetail,
                      )
                    ],
                  ),
                  SizedBox(
                    height: space_height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Cửa hàng",
                        style: Constants.titleProductDetail,
                      ),
                      Text(
                        product.store,
                        style: Constants.contentProductDetail,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text(
                          'Chi tiết',
                          style: TextStyle(
                              fontSize: footnote, color: mPrimaryColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailScreen(product);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
