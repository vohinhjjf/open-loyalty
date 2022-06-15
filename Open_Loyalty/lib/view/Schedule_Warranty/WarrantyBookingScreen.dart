import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/warranty_model.dart';
import 'package:rxdart/rxdart.dart';

class WarrantyBookingManagement extends StatefulWidget {
  @override
  _WarrantyBookingManagementState createState() =>
      _WarrantyBookingManagementState();
}

class _WarrantyBookingManagementState extends State<WarrantyBookingManagement> {
  final _repository = Repository();
  final _warrantyBookFetcher = PublishSubject<ListWarrantyModel>();

  Stream<ListWarrantyModel> get warrantyBook => _warrantyBookFetcher.stream;

  fetchListWarrantyBook() async {
    if (!_warrantyBookFetcher.isClosed) {
      print("fetch points");
      ListWarrantyModel warrantyBookModel =
          await _repository.fetchCustomerWarrantyBooking();
      _warrantyBookFetcher.sink.add(warrantyBookModel);
    }
  }

  TextEditingController productSku = new TextEditingController();
  TextEditingController date = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchListWarrantyBook();
  }

  @override
  void dispose() {
    _warrantyBookFetcher.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Thông tin đăng ký bảo hành',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: warrantyBook,
          builder: (context, AsyncSnapshot<ListWarrantyModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.total == 0) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                          style: TextStyle(
                              color: Colors.grey, fontSize: mFontSize)),
                      SizedBox(
                        height: 20.0,
                      ),
                      SvgPicture.asset(
                        "assets/images/empty.svg",
                        height: size.height * 0.3,
                      ),
                    ],
                  ),
                );
              }
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget buildList(AsyncSnapshot<ListWarrantyModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.total,
      itemBuilder: (context, index) {
        return bookingList(snapshot.data!.warrantyModels[index]);
      },
    );
  }

  Widget bookingList(WarrantyModel warrantyModel) {
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
              height: 160,
              padding: EdgeInsets.fromLTRB(30, 20, 10, 20),
              child: Column(children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Colors.grey,
                      size: 13,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Text(
                        DateFormat("dd-MM-yyyy hh:mm a")
                            .format(warrantyModel.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(
                      width: 130,
                    ),
                    InkWell(
                      onTap: () {
                        /*setState(() {
                          product = getProduct(warrantyModel.productSku);
                        });
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return EditBookingScreen(
                                product,
                                warrantyModel.bookingDate,
                                warrantyModel.bookingTime,
                                warrantyModel.warrantyCenter,
                                warrantyModel.maintenanceId,
                                warrantyModel.discription,
                                warrantyModel.cost,
                                warrantyModel.paymentStatus,
                                1);
                          },
                        ));*/
                      },
                      child: FaIcon(
                        FontAwesomeIcons.edit,
                        color: Colors.grey,
                        size: footnote,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mã sản phẩm",
                          style: Constants.titleProductDetail,
                        ),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(
                          "Thời gian đến",
                          style: Constants.titleProductDetail,
                        ),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(
                          "Trung tâm bảo hành",
                          style: Constants.titleProductDetail,
                        ),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(
                          "Tình trạng",
                          style: Constants.titleProductDetail,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(warrantyModel.productSku,
                            style: Constants.contentProductDetail),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(
                            DateFormat("dd-MM-yyyy")
                                    .format(warrantyModel.bookingDate) +
                                " " +
                                warrantyModel.bookingTime,
                            style: Constants.contentProductDetail),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(warrantyModel.warrantyCenter,
                            style: Constants.contentProductDetail),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(warrantyModel.active ? "Chưa đến" : "Đã đến",
                            style: Constants.contentProductDetail),
                      ],
                    )
                  ],
                ),
              ])),
        ));
  }
}
