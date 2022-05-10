import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/product_model.dart';
import 'package:open_loyalty/models/warranty_model.dart';
import 'package:open_loyalty/view/booking_management/MaintenanceBookingManagement.dart';
import 'package:open_loyalty/view/Schedule_Warranty/WarrantyBookingScreen.dart';
import 'package:open_loyalty/view/Schedule_Warranty/components/warranty_center.dart';

class BookingConfirmed extends StatefulWidget {
  final DateTime _bookingDate;
  final String _time;
  final String _center;
  final ProductModel product;

  BookingConfirmed(this._bookingDate, this._time, this._center, this.product);
  @override
  _BookingConfirmedState createState() => _BookingConfirmedState();
}

class _BookingConfirmedState extends State<BookingConfirmed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
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
            'Thông tin đăng kí',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: space_height),
          child: Column(
            children: [
              info(),
              SizedBox(height: space_height),
              time(),
              SizedBox(height: space_height),
              warrantyCenter(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SizedBox(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: mPrimaryColor)),
                    color: mPrimaryColor,
                    textColor: Colors.white,
                    child: Text('Xác nhận',
                        style: TextStyle(
                            fontSize: subhead, fontWeight: FontWeight.w500)),
                    onPressed: () {
                      setState(() {
                        if (widget.product.warrantyExpired
                                .compareTo(DateTime.now()) >
                            0) {
                          print('bookingWarranty');
                          if (widget._center != null) {
                            print('thành công');
                                bookingWarranty(
                                    widget.product.productSku,
                                    widget._center,
                                    widget._bookingDate,
                                    widget._time,
                                    DateTime.now())
                                .then((value) => {
                                      if (value != null)
                                        {_showMaterialDialog()}
                                      else
                                        {_showErrorDialog()}
                                    });
                          } else {
                            _showErrorDialog();
                          }
                        } else {
                          if (widget._center != null) {
                            print('booking');
                            booking(
                                    widget.product.productSku,
                                    widget._center,
                                    widget._bookingDate,
                                    widget._time,
                                    DateTime.now())
                                .then((value) => {
                                      if (value != null)
                                        {_showMaterialDialog()}
                                      else
                                        {_showErrorDialog()}
                                    });
                          } else {
                            _showErrorDialog();
                          }
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: new Image(
                width: 130,
                height: 130,
                image: AssetImage("assets/images/success.gif"),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Thông tin đăng kí của bạn đã được lưu lại!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                            child: Text('Quay lại',
                                style: TextStyle(
                                    color: mPrimaryColor, fontSize: 15)),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: mPrimaryColor)),
                            color: mPrimaryColor,
                            child: Text('Xem chi tiết',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              if (widget.product.warrantyExpired
                                      .compareTo(DateTime.now()) >
                                  0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WarrantyBookingManagement();
                                    },
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MaintenanceBookingManagementScreen();
                                    },
                                  ),
                                );
                              }
                            })
                      ])
                ],
              ),
            ));
  }

  _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: Container(
                child: Column(
                  children: [
                    Image(
                      width: 250,
                      height: 250,
                      image: AssetImage("assets/images/error.gif"),
                    ),
                    Text(
                      "Đăng ký không thành công",
                      style: TextStyle(fontSize: mFontSize, color: Colors.red),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bạn vui lòng kiểm tra lại thông tin đăng kí nhé!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.black, fontSize: mFontSize),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: mPrimaryColor)),
                        color: mPrimaryColor,
                        child: Text('Quay lại',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        })
                  ],
                ),
              ),
            ));
  }

  Widget time() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ngày dự kiến: ",
                style: TextStyle(fontSize: subhead, color: Colors.grey),
              ),
              SizedBox(
                height: space_height * 2,
              ),
              Text(
                "Thời gian: ",
                style: TextStyle(fontSize: subhead, color: Colors.grey),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd-MM-yyyy').format(widget._bookingDate),
                style: TextStyle(fontSize: subhead),
              ),
              SizedBox(
                height: space_height * 2,
              ),
              Text(
                widget._time,
                style: TextStyle(fontSize: subhead),
              )
            ],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Widget warrantyCenter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Chọn trung tâm bảo hành",
                style: TextStyle(fontSize: subhead, color: mPrimaryColor),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: mPrimaryColor,
                    size: subhead,
                  ),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WarrantyCenter(widget._bookingDate,
                                widget._time, widget.product);
                          },
                        ),
                      ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget._center.isNotEmpty ? widget._center : "",
                style: TextStyle(fontSize: subhead, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Tên sản phẩm: ",
                style: TextStyle(fontSize: subhead, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: space_height * 2,
          ),
          Row(
            children: [
              Text(
                widget.product.productName,
                style: TextStyle(fontSize: subhead),
              )
            ],
          )
        ],
      ),
    );
  }
}
