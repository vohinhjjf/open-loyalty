import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/product_model.dart';
import 'package:open_loyalty/view/Schedule_Warranty/Warranty_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen(this.product);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: mPrimaryColor,
              size: subhead,
            ),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Thông tin sản phẩm',
          style: TextStyle(
            fontSize: subhead,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(children: [
        Stack(
          children: [
            Positioned(
              top: size.height * 0.008,
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //     topRight: Radius.circular(56),
                    //     topLeft: Radius.circular(56)),
                  ),
                  width: size.width,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 280,
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: AssetImage(widget.product.image),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(widget.product.productName,
                            style: TextStyle(
                                fontSize: mFontTitle,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mã sản phẩm",
                                  style: Constants.titleProductDetail,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(widget.product.productSku,
                                    style: Constants.contentProductDetail),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Giá",
                                  style: Constants.titleProductDetail,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(formatNumber(widget.product.price),
                                    style: Constants.contentProductDetail),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hãng",
                                  style: Constants.titleProductDetail,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(widget.product.brand,
                                    style: Constants.contentProductDetail),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          color: mDividerColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Thông tin bảo hành",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: subhead,
                                  color: mPrimaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hạn bảo hành:",
                              style: Constants.titleProductDetail,
                            ),
                            Text(
                              DateFormat("dd/MM/yyyy")
                                  .format(widget.product.warrantyExpired),
                              style: TextStyle(
                                  fontSize: footnote,
                                  color: widget.product.warrantyExpired
                                              .compareTo(DateTime.now()) >
                                          0
                                      ? Colors.black
                                      : Colors.red),
                            ),
                            Text(
                              widget.product.warrantyExpired
                                          .compareTo(DateTime.now()) >
                                      0
                                  ? "(Còn hạn)"
                                  : "(Hết hạn)",
                              style: TextStyle(
                                  fontSize: footnote,
                                  color: widget.product.warrantyExpired
                                              .compareTo(DateTime.now()) >
                                          0
                                      ? Colors.black
                                      : Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ngày mua",
                                    style: Constants.titleProductDetail),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                    DateFormat("dd/MM/yyyy")
                                        .format(widget.product.purchaseDate),
                                    style: Constants.contentProductDetail),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Thời hạn bảo hành",
                                    style: Constants.titleProductDetail),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("1 Năm",
                                    style: Constants.contentProductDetail),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: size.width,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(color: mPrimaryColor)),
                            color: mPrimaryColor,
                            textColor: Colors.white,
                            child: Text(
                                widget.product.warrantyExpired
                                            .compareTo(DateTime.now()) >
                                        0
                                    ? 'Đặt lịch bảo hành'
                                    : 'Đặt lịch bảo trì',
                                style: TextStyle(
                                    fontSize: body,
                                    fontWeight: FontWeight.w500)),
                            onPressed: () {
                              print(widget.product.warrantyId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return WarrantyScreen(
                                      widget.product,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
