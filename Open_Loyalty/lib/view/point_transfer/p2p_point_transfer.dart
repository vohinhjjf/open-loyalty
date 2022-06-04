import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:rxdart/rxdart.dart';

import '../../Firebase/respository.dart';
import '../../models/point_model.dart';

class P2PTransferPoint extends StatefulWidget {
  final String point;
  P2PTransferPoint(this.point);

  @override
  _P2PTransferPointState createState() => _P2PTransferPointState();
}

class _P2PTransferPointState extends State<P2PTransferPoint> {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController pointController = new TextEditingController();
  final _repository = Repository();
  final _pointTransferFetcher = PublishSubject<ListPointTransferModel>();

  Stream<ListPointTransferModel> get pointTransfer =>
      _pointTransferFetcher.stream;
  late String point;

  Future<String?> transferPoint(
      String receiver,
      double point
      ) async {
    return await _repository.PointTransfer(receiver, point);
  }

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
    // TODO: implement initState
    super.initState();
    point = widget.point;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    pointController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: subhead,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Chuyển điểm',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              phoneInput(),
              const SizedBox(
                height: space_height,
              ),
              pointData(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: size.width,
                  height: 46,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: mPrimaryColor)),
                    color: mPrimaryColor,
                    textColor: Colors.white,
                    child: const Text("Chuyển điểm",
                        style: TextStyle(
                            fontSize: subhead, fontWeight: FontWeight.w500)),
                    onPressed: () {
                      if (double.parse(point) >=
                          double.parse(pointController.text) && point != "") {
                        transferPoint(phoneController.text,
                                double.parse(pointController.text))
                            .then((value) => {
                                print(value),
                                if (value != null)
                                  {
                                    _repository.UpdatePointSender(phoneController.text,double.parse(pointController.text)),
                                    _repository.UpdatePointReceiver(phoneController.text,double.parse(pointController.text)),
                                    _showMaterialDialog()}
                                else
                                  {_showErrorDialog()}
                              });
                      } else {
                        _showErrorDialog();
                      }
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
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: const Image(
                width: 130,
                height: 130,
                image: AssetImage("assets/images/success.gif"),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: const Text(
                      "Bạn đã chuyển điểm thành công!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                            child: const Text('Màn hình chính',
                                style: TextStyle(
                                    color: mPrimaryColor, fontSize: subhead)),
                            onPressed: () {
                              setState(() {
                                point = (double.parse(point) -
                                        double.parse(pointController.text))
                                    .toString();
                                phoneController.text = "";
                                pointController.text = "";
                                fetchPointTransfer();
                              });
                              Navigator.popAndPushNamed(context, '/home');
                            }),
                      ])
                ],
              ),
            ));
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
                      "Bạn vui lòng kiểm tra lại điểm hoặc số điện thoại nhé!",
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

  Widget phoneInput() {
    return Container(
      margin: EdgeInsets.only(top: space_height),
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nhập số điện thoại",
            style: TextStyle(fontSize: footnote),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            phoneController.text == "0909090909" ? "John Doe" : "",
            style: const TextStyle(fontSize: footnote),
          )
        ],
      ),
    );
  }

  Widget pointData() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Điểm khả dụng", style: TextStyle(fontSize: footnote)),
              Text(point + " Điểm", style: TextStyle(fontSize: footnote))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Nhập số điểm", style: const TextStyle(fontSize: footnote)),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: pointController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          )
        ],
      ),
    );
  }
}
