import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Firebase/respository.dart';
import '../../models/warranty_model.dart';

class FindWarrntyScreen extends StatefulWidget {
  @override
  _FindWarrntyScreenState createState() => _FindWarrntyScreenState();
}

class _FindWarrntyScreenState extends State<FindWarrntyScreen> {
  var warranty_id = TextEditingController();
  final _repository = Repository();
  final _warrantyBookFetcher = PublishSubject<WarrantyModel>();

  Stream<WarrantyModel> get warrantyBook => _warrantyBookFetcher.stream;

  fetchListWarrantyBook(String id) async {
    if (!_warrantyBookFetcher.isClosed) {
      print("fetch points");
      WarrantyModel warrantyBookModel =
      await _repository.CheckWarrantyBooking(id);
        _warrantyBookFetcher.sink.add(warrantyBookModel);
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
            'Phiếu bảo hành',
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
                      controller: warranty_id,
                      decoration: const InputDecoration(
                          hintText: 'ID phiếu bảo hành',
                          hintStyle: TextStyle(fontSize: mFontSize),
                          contentPadding: EdgeInsets.zero
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Vui lòng nhập ID phiếu bảo hành';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        fetchListWarrantyBook(warranty_id.text);
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
      stream: warrantyBook,
      builder: (context, AsyncSnapshot<WarrantyModel> snapshot) {
        if (snapshot.hasData) {
          return bookingList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget bookingList(WarrantyModel warrantyModel) {
    return warrantyModel.warrantyId == ""
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
                "Không tìm thấy phiếu bảo hành!",
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
              'Phiếu bảo trì ${warrantyModel.warrantyId}',
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
                    DateFormat("dd-MM-yyyy hh:mm a")
                        .format(warrantyModel.createdAt),
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
          title: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.blue,
              size: mFontSize,
            ),
          ),
          content: buildList(),
        ));
  }
}