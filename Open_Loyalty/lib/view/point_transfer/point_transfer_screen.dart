import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/point_model.dart';
import 'package:rxdart/rxdart.dart';

class PointTransfer extends StatefulWidget {
  @override
  _PointTransferState createState() => _PointTransferState();
}

class _PointTransferState extends State<PointTransfer> {
  final _repository = Repository();
  final _pointTransferFetcher = PublishSubject<ListPointTransferModel>();

  Stream<ListPointTransferModel> get pointTransfer =>
      _pointTransferFetcher.stream;

  fetchPointTransfer() async {
    if (!_pointTransferFetcher.isClosed) {
      print("fetch points");
      ListPointTransferModel pointTransferModel =
      await _repository.fetchPointTransfer();
      _pointTransferFetcher.sink.add(pointTransferModel);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPointTransfer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            icon:
            Icon(Icons.arrow_back_ios, color: mPrimaryColor, size: subhead),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Lịch sử sử dụng điểm',
          style: TextStyle(
            fontSize: subhead,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: pointTransfer,
        builder: (context, AsyncSnapshot<ListPointTransferModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.total == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    const Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                        style:
                        TextStyle(color: Colors.grey, fontSize: mFontSize)),
                    const SizedBox(
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

  Widget buildList(AsyncSnapshot<ListPointTransferModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.total,
      itemBuilder: (context, index) {
        return pointtransfer(snapshot.data!.pointTransferModels[index]);
      },
    );
  }

  Widget pointtransfer(PointTransferModel pointTransferModel) {
    User? user = FirebaseAuth.instance.currentUser;
    String Comment(String comment){
      var cm;
      if(comment == 'newuser'){
        cm  = 'Chào bạn mới';
      }
      else if(pointTransferModel.customerId == user?.uid){
        cm =  'Chuyển điểm đến số điện thoại '+comment;
      }
      else{
        cm = 'Nhận điểm từ số điện thoại '+ comment;
      }
      return cm;
    }
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
              height: 180,
              padding: EdgeInsets.fromLTRB(30, 20, 10, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Colors.grey,
                      size: 13,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                        DateFormat("dd/MM/yyyy hh:mm a")
                            .format(pointTransferModel.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                SizedBox(
                  height: space_height,
                ),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Điểm",
                            style: Constants.titleProductDetail,
                          ),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                            "Loại",
                            style: Constants.titleProductDetail,
                          ),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                            "Nội dung",
                            style: Constants.titleProductDetail,
                          ),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                            "Hạn sử dụng",
                            style: Constants.titleProductDetail,
                          ),
                        ]),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              pointTransferModel.type == "adding"
                              ? '+'+pointTransferModel.value.toString()
                              : '-'+pointTransferModel.value.toString(),
                              style: Constants.contentProductDetail),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                              pointTransferModel.type == "adding"
                                  ? "Tích điểm"
                                  : "Sử dụng điểm",
                              style: Constants.contentProductDetail),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                              Comment(pointTransferModel.comment),
                              style: Constants.contentProductDetail),
                          SizedBox(
                            height: space_height * 2,
                          ),
                          Text(
                              DateFormat("dd/MM/yyyy hh:mm a")
                                  .format(pointTransferModel.expiresAt),
                              style: Constants.contentProductDetail),
                        ])
                  ],
                )
              ])),
        ));
  }
}