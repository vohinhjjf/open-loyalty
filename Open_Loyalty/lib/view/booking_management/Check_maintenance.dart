import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Firebase/respository.dart';
import '../../models/maintenance.dart';
import '../../models/warranty_model.dart';

class FindMaintenanceScreen extends StatefulWidget {
  @override
  _FindMaintenanceScreenState createState() => _FindMaintenanceScreenState();
}

class _FindMaintenanceScreenState extends State<FindMaintenanceScreen> {
  var maintenance_id = TextEditingController();
  final _repository = Repository();
  final _maintenanceBookFetcher = PublishSubject<MaintenanceModel_1>();

  Stream<MaintenanceModel_1> get maintenanceBook => _maintenanceBookFetcher.stream;

  fetchMaintenanceBook(String id) async {
    if (!_maintenanceBookFetcher.isClosed) {
      print("fetch points");
      MaintenanceModel_1 maintenanceBookModel =
      await _repository.CheckMaintenanceBooking(id);
      _maintenanceBookFetcher.sink.add(maintenanceBookModel);
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: mFontSize,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Phiếu bảo trì',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: maintenance_id,
                  decoration: const InputDecoration(
                      hintText: 'ID phiếu bảo trì',
                      hintStyle: TextStyle(fontSize: mFontSize),
                      contentPadding: EdgeInsets.zero
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Vui lòng nhập ID phiếu bảo trì';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16,),
                InkWell(
                  onTap: (){
                    fetchMaintenanceBook(maintenance_id.text);
                    _showDialog();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: LinearGradient(colors: [
                          mHighColor,
                          Colors.lightBlue,
                          Colors.lightBlueAccent
                        ])
                    ),
                    child: const Center(
                      child: Text(
                        'Tìm kiếm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildList() {
    return StreamBuilder(
      stream: maintenanceBook,
      builder: (context, AsyncSnapshot<MaintenanceModel_1> snapshot) {
        if (snapshot.hasData) {
          return bookingList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget bookingList(MaintenanceModel_1 maintenanceModel) {
    return maintenanceModel.maintenanceId == ""
        ? Container(
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
            "Không tìm thấy phiếu bảo trì!",
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
    )
        : Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(children: [
          Text(
            'Phiếu bảo trì ${maintenanceModel.maintenanceId}',
            style: TextStyle(color: mPrimaryColor, fontSize: mFontListTile),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.clock,
                color: Colors.grey,
                size: 13,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                  DateFormat("dd/MM/yyyy")
                      .format(maintenanceModel.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                    "Phí bảo trì",
                    style: Constants.titleProductDetail,
                  ),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(
                    "Mô tả",
                    style: Constants.titleProductDetail,
                  ),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(
                    "Tình trạng",
                    style: Constants.titleProductDetail,
                  ),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(
                    "Tình trạng thanh toán",
                    style: Constants.titleProductDetail,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(maintenanceModel.productSku,
                      style: Constants.contentProductDetail),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(
                      DateFormat("dd/MM/yyyy")
                          .format(maintenanceModel.bookingDate) +
                          " " +
                          maintenanceModel.bookingTime,
                      style: Constants.contentProductDetail),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(maintenanceModel.warrantyCenter,
                      style: Constants.contentProductDetail),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(maintenanceModel.cost,
                      style: Constants.contentProductDetail),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(maintenanceModel.discription,
                      style: Constants.contentProductDetail),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(maintenanceModel.active ? "Chưa đến" : "Đã đến",
                      style: TextStyle(
                          fontSize: footnote,
                          color: maintenanceModel.active
                              ? Colors.black
                              : Colors.grey)),
                  SizedBox(
                    height: space_height,
                  ),
                  Text(
                      maintenanceModel.paymentStatus == "paid"
                          ? "Đã thanh toán"
                          : "Chưa thanh toán",
                      style: TextStyle(
                          fontSize: footnote,
                          color:
                          maintenanceModel.paymentStatus == "paid"
                              ? Colors.green
                              : Colors.red)),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
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

        ])
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: buildList(),
        ));
  }
}