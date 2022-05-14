import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_widget/barcode_widget.dart';

class VoucherDetail extends StatefulWidget {
  final String status;
  final String code;
  final String time;
  VoucherDetail(this.status, this.code, this.time);

  @override
  _VoucherDetailState createState() => _VoucherDetailState();
}

class _VoucherDetailState extends State<VoucherDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
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
            'Voucher',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Giảm 20% tối đa 100.000đ",
                              style: TextStyle(
                                  fontSize: subhead,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Trạng thái",
                              style: TextStyle(
                                  fontSize: footnote, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              widget.status,
                              style: TextStyle(
                                  fontSize: footnote, color: Colors.green),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: space_height,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              "Hết hạn",
                              style: TextStyle(
                                  fontSize: footnote, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              widget.time,
                              style: TextStyle(fontSize: footnote),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: space_height,
                      ),
                      QrImage(
                        data: widget.code,
                        version: QrVersions.auto,
                        size: 220.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BarcodeWidget(
                        barcode: Barcode.code128(), // Barcode type and settings
                        data: "123", // Content
                        width: 200,
                        height: 80,
                        color: Colors.black,
                        drawText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
