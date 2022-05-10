import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/models/warranty_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/maintenance.dart';


class MaintenanceBookingManagementScreen extends StatefulWidget {
  @override
  _MaintenanceBookingManagementScreenState createState() =>
      _MaintenanceBookingManagementScreenState();
}

class _MaintenanceBookingManagementScreenState
    extends State<MaintenanceBookingManagementScreen> {
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
  TextEditingController productSku = new TextEditingController();
  TextEditingController date = new TextEditingController();

  String zpTransToken = "";
  String payResult = "";

  final _repository = Repository();
  final _maintenanceBookFetcher = PublishSubject<ListMaintenanceModel_1>();

  Stream<ListMaintenanceModel_1> get maintenanceBook =>
      _maintenanceBookFetcher.stream;

  fetchListMaintenanceBook() async {
    if (!_maintenanceBookFetcher.isClosed) {
      ListMaintenanceModel_1 maintenanceBookModel =
      await _repository.fetchCustomerMaintenanceBooking();
      _maintenanceBookFetcher.sink.add(maintenanceBookModel);
      print(maintenanceBookModel.total);
    }
  }
  @override
  void initState() {
    super.initState();
    fetchListMaintenanceBook();
  }

  @override
  void dispose() {
    _maintenanceBookFetcher.close();
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
        title: Text(
          'Thông tin đăng ký bảo trì',
          style: TextStyle(
            fontSize: subhead,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: maintenanceBook,
        builder: (context, AsyncSnapshot<ListMaintenanceModel_1> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.total == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                        style:
                        TextStyle(color: Colors.grey, fontSize: mFontSize)),
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
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ListMaintenanceModel_1> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.total,
      itemBuilder: (context, index) {
        return bookingList(snapshot.data!.maintenanceModels[index]);
      },
    );
  }

  Widget bookingList(MaintenanceModel_1 maintenanceModel) {
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
              height: maintenanceModel.paymentStatus == "paid" ? 220 : 250,
              padding: EdgeInsets.fromLTRB(30, 20, 10, 0),
              child: Column(
                children: [
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
                          DateFormat("dd/MM/yyyy")
                              .format(maintenanceModel.createdAt),
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      SizedBox(
                        width: 130,
                      ),
                      InkWell(
                        onTap: () {
                          /*setState(() {
                            product = getProduct(maintenanceModel.productSku);
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return EditBookingScreen(
                                    product,
                                    maintenanceModel.bookingDate,
                                    maintenanceModel.bookingTime,
                                    maintenanceModel.warrantyCenter,
                                    maintenanceModel.maintenanceId,
                                    maintenanceModel.discription,
                                    maintenanceModel.cost,
                                    maintenanceModel.paymentStatus,
                                    2);
                              }));*/
                        },
                        child: FaIcon(
                          Icons.edit,
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
                        width: 30,
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        maintenanceModel.paymentStatus == "unpaid"
                            ? TextButton(
                          child: const Text(
                            'Thanh toán',
                            style: TextStyle(
                                color: mPrimaryColor, fontSize: footnote),
                          ),
                          onPressed: () async {

                          },
                        )
                            : SizedBox(width: 1),
                        const SizedBox(width: 8)
                      ])
                ],
              )),
        ));
  }
}

class Repository {
  final customerApiProvider = CustomerApiProvider();

  Future<ListMaintenanceModel_1> fetchCustomerMaintenanceBooking() =>
      customerApiProvider.fetchCustomerMaintenanceBooking();

  Future<ListWarrantyModel> fetchCustomerWarrantyBooking() =>
      customerApiProvider.fetchCustomerWarrantyBooking();
}

class CustomerApiProvider {
  Future<ListMaintenanceModel_1> fetchCustomerMaintenanceBooking() async {
    //get value store in FirebaseFireStore.
    final User? user = FirebaseAuth.instance.currentUser;
    var maintenance = FirebaseFirestore.instance.collection('Maintenance');
    var docSnapshot = await maintenance.doc(user?.uid).get();
    MaintenanceModel_1 trans1 = MaintenanceModel_1();
    List<MaintenanceModel_1> temp = [];
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var length = data.length;
      for(int i =0; i< length; i++) {
        print(i);
        trans1.maintenanceId = "$i";
        trans1.productSku = data['maintenance $i']['maintenanceData']['productSku'];
        trans1.bookingDate =
            DateTime.parse(data['maintenance $i']['maintenanceData']['bookingDate'])
                .toLocal();
        trans1.bookingTime = data['maintenance $i']['maintenanceData']['bookingTime'];
        trans1.warrantyCenter =
        data['maintenance $i']['maintenanceData']['warrantyCenter'];
        trans1.createdAt =
            DateTime.parse(data['maintenance $i']['maintenanceData']['createdAt']);
        trans1.active = data['maintenance $i']['maintenanceData']['active'];
        trans1.discription = data['maintenance $i']['maintenanceData']['description'];
        trans1.cost = data['maintenance $i']['maintenanceData']['cost'];
        trans1.paymentStatus =
        data['maintenance $i']['maintenanceData']['paymentStatus'];
        temp.add(trans1);
      }
    }
    return ListMaintenanceModel_1(maintenanceModels: temp, total: temp.length);
  }
  Future<ListWarrantyModel> fetchCustomerWarrantyBooking() async {
    //get value store in FirebaseFireStore.
    final User? user = FirebaseAuth.instance.currentUser;
    var warranty = FirebaseFirestore.instance.collection('Warranty');
    var docSnapshot = await warranty.doc(user?.uid).get();
    WarrantyModel trans1 = WarrantyModel();
    List<WarrantyModel> temp = [];
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var length = data.length;
      for(int i = 0; i< length; i++) {
        print(i);
        trans1.maintenanceId = "$i";
        trans1.productSku = data['warranty $i']['warrantyData']['productSku'];
        trans1.bookingDate =
            DateTime.parse(data['warranty $i']['warrantyData']['bookingDate'])
                .toLocal();
        trans1.bookingTime = data['warranty $i']['warrantyData']['bookingTime'];
        trans1.warrantyCenter =
        data['warranty $i']['warrantyData']['warrantyCenter'];
        trans1.createdAt =
            DateTime.parse(data['warranty $i']['warrantyData']['createdAt']);
        trans1.active = data['warranty $i']['warrantyData']['active'];
        trans1.discription = data['warranty $i']['warrantyData']['description'];
        trans1.cost = data['warranty $i']['warrantyData']['cost'];
        trans1.paymentStatus =
        data['warranty $i']['warrantyData']['paymentStatus'];
        temp.add(trans1);
      }
    }
    return ListWarrantyModel(warrantyModels: temp, total: temp.length);

  }
}
