import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:open_loyalty/models/maintenance.dart';
import '../../constant.dart';
import '../../models/customer_model.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../account_screen/account_screen.dart';
import '../booking_management/MaintenanceBookingManagement.dart';
import '../product/product_screen.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  late AsyncSnapshot<ListMaintenanceModel_1> snapshot;

  @override
  Widget build(BuildContext context) {

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: mPrimaryColor,
                borderRadius: BorderRadius.all(Radius.circular(28) //
                ),
              ),
              width: 344,
              height: 199,
              margin: EdgeInsets.all(10.0),
              child: StreamBuilder<CustomerModel>(

                  builder: (context, AsyncSnapshot<CustomerModel> snapshot) {
                    print(snapshot.connectionState);
                    return cardInfo();

                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 14),
              child: Text(
                "Danh mục dịch vụ",
                style: TextStyle(
                    fontSize: mFontTitle,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              height: 144,
              margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.shopping_basket_outlined),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Sản phẩm",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.support_agent_outlined),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Hỗ trợ",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          /*onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CampaignScreen();
                                },
                              ),
                            );
                          },*/
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.card_giftcard,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Đổi điểm",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          /*onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GetMyStores();
                                },
                              ),
                            );
                          },*/
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.only(left: 18),
                            height: 64,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.store,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "Cửa hàng",
                                      style: Constants.titleService,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 18),
              child: Text(
                "Khuyến mãi hấp dẫn 🎉",
                style: TextStyle(
                    fontSize: mFontTitle,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),

            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      // ignore: missing_required_param
                      child: CarouselSlider(

                          items: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/carousel1.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/carousel2.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/carousel3.jpg"),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),

                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 18,
            ),
          ]),
    );
  }

  Widget cardInfo() {
    var _fullName = "Nguyễn Minh Thái";
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tên khách hàng",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    _fullName,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "123456789",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            "assets/images/login_bottom.png",
            width: size.width * 0.4,
          ),
        ),
        Positioned(
          top: 90,
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: "123456789", // Content
              width: 200,
              height: 60,
              color: Colors.white,
              drawText: false,
            ),
          ),
        ),
      ],
    );
  }
}