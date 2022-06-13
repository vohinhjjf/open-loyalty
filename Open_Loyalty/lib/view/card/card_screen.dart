import 'package:decorated_icon/decorated_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/models/maintenance.dart';
import 'package:open_loyalty/view/campaign/campaign_screen.dart';
import 'package:open_loyalty/view/campaign/edit_voucher_screen.dart';
import '../../constant.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../product/product_screen.dart';
import '../stores/stores_screen.dart';
import '../support/start_conversation_screen.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    super.initState();
  }

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
  late AsyncSnapshot<ListMaintenanceModel_1> snapshot;
  late Future<CustomerModel?> _value;
  final _repository = Repository();

  @override
  initState() {
    super.initState();
    _value = _repository.getCustomerData();
  }
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            user?.email == "admin@gmail.com"
            ? Container()
            : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28) //
                    ),
                gradient: const LinearGradient(colors: [
                  mHighColor,
                  Colors.lightBlue,
                  Colors.lightBlueAccent
                ])
              ),
              width: 344,
              height: 199,
              margin: const EdgeInsets.all(10.0),
              child: FutureBuilder<CustomerModel?>(
                  future: _value,
                  builder: (context, AsyncSnapshot<CustomerModel?> snapshot) {
                print(snapshot.connectionState);
                if (snapshot.hasData) {
                  return cardInfo(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              }),
            ),
            const Padding(
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
                margin: const EdgeInsets.only(left: 16, right: 16, top: 14),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      // ignore: missing_required_param
                      child: CarouselSlider(
                        items: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/carousel1.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/carousel2.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/carousel3.jpg"),
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
                          autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ),

                  ],
                )),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 14),
              child: Text(
                "Danh mục dịch vụ",
                style: TextStyle(
                    fontSize: mFontTitle,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            user!.email == 'admin@gmail.com'
            ? Container(
              height: 350,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StartConverstionScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  //Colors.green[500]
                                  Colors.lightGreenAccent,
                                  Color(0xFF76FF03),
                                  Color(0xFF64DD17),
                                  Color(0xFF64DD17),
                                  Color(0xFF76FF03),
                                  Colors.lightGreenAccent,
                                ]),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: Color(0xFF00E676), width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                DecoratedIcon(
                                  Icons.support_agent_outlined,
                                  color: Colors.black,
                                  size: 30.0,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
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
                    flex: 3,
                      ), //Hỗ trợ
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditVoucherScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(left: 16),
                        height: 64,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFFFCC80),
                              Colors.orange,
                              Colors.deepOrangeAccent,
                              Colors.orange,
                              Color(0xFFFFCC80),
                            ]),
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.deepOrangeAccent, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            DecoratedIcon(
                              Icons.card_giftcard,
                              color: Colors.black,
                              size: 30.0,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Voucher",
                                  style: Constants.titleService,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ), //voucher
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GetMyStores();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(left: 18),
                        height: 64,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFF81D4FA),
                              Colors.lightBlue,
                              Color(0xFF00B0FF),
                              Colors.lightBlue,
                              Color(0xFF81D4FA),
                            ]),
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: mPrimaryColor, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            DecoratedIcon(
                              Icons.store,
                              color: Colors.black,
                              size: 30.0,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Colors.white,
                                ),
                              ],
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
                    flex: 3,
                  ), //Cửa hàng
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GetMyStores();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(left: 18),
                        height: 64,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE1BEE7),
                              Colors.purpleAccent,
                              Color(0xFFD500F9),
                              Colors.purpleAccent,
                              Color(0xFFE1BEE7),
                            ]),
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.purple, width: 1)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            DecoratedIcon(
                              Icons.business_center,
                              color: Colors.black,
                              size: 30.0,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Bảo hành",
                                  style: Constants.titleService,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ), //Bảo hành
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return GetMyStores();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.only(left: 18),
                        height: 64,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xFFFFF9C4),
                              Colors.yellowAccent,
                              Color(0xFFFFEA00),
                              Colors.yellowAccent,
                              Color(0xFFFFF9C4),
                            ]),
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: mPrimaryColor, width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            DecoratedIcon(
                              Icons.construction,
                              color: Colors.black,
                              size: 30.0,
                              shadows: [
                                BoxShadow(
                                  blurRadius: 12.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Bảo trì",
                                  style: Constants.titleService,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flex: 3,
                  ), //Bảo trì
                ],
              ),
            )
            : Container(
              height: 144,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if(user.email == "admin@gmail.com")
                            {
                              _showErrorDialog();
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProductScreen();
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.purpleAccent,
                                  Colors.white
                                ]),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: Colors.purple, width: 1)
                            ),
                            child: Row(
                              children: const <Widget>[
                                DecoratedIcon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                  size: 30.0,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
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
                      ), //Giỏ hàng
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return StartConverstionScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  //Colors.green[500]
                                  Color(0xFF00E676),
                                  Color(0xFF64DD17),
                                  Colors.lightGreenAccent,
                                  Colors.white
                                ]),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Color(0xFF00E676), width: 1)),
                            child: Row(
                              children: const <Widget>[
                                DecoratedIcon(
                                  Icons.support_agent_outlined,
                                  color: Colors.black,
                                  size: 30.0,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
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
                      ) //Hỗ trợ
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CampaignScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(left: 16),
                            height: 64,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.deepOrangeAccent,
                                  Colors.orange, Colors.white
                                ]),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: Colors.deepOrangeAccent, width: 1)),
                            child: Row(
                              children: const <Widget>[
                                DecoratedIcon(
                                  Icons.card_giftcard,
                                  color: Colors.black,
                                  size: 30.0,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Colors.white,
                                    ),
                                  ],
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
                      ), //Đổi điểm
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GetMyStores();
                                },
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(left: 18),
                            height: 64,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  mHighColor,
                                  Colors.lightBlue,
                                  Colors.lightBlueAccent,
                                  Colors.white
                                ]),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: mPrimaryColor, width: 1)),
                            child: Row(
                              children: const <Widget>[
                                DecoratedIcon(
                                  Icons.store,
                                  color: Colors.black,
                                  size: 30.0,
                                  shadows: [
                                    BoxShadow(
                                      blurRadius: 12.0,
                                      color: Colors.white,
                                    ),
                                  ],
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
                      ) //Cửa hàng
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ]),
    );
  }

  Widget cardInfo(CustomerModel? CustomerModel) {
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
                  const Text(
                    "Tên khách hàng",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    CustomerModel!.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ID",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    CustomerModel.loyaltyCardNumber,
                    style: const TextStyle(
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
          top: 90,
          left: 0,
          right: 25,
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: BarcodeWidget(
              barcode: Barcode.code128(), // Barcode type and settings
              data: CustomerModel.loyaltyCardNumber, // Content
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

  _showErrorDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Container(
            child: Column(
              children: [
                const Image(
                  width: 250,
                  height: 250,
                  image: AssetImage("assets/images/error.gif"),
                ),
                const Text(
                  "Thất bại",
                  style: TextStyle(fontSize: mFontSize, color: Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Chức năng này hiện không khả dụng!",
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(color: Colors.black, fontSize: mFontSize),
                ),
                const SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: mPrimaryColor)),
                    color: mPrimaryColor,
                    child: const Text('Quay lại',
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
}
