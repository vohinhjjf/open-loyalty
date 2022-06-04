import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/view/point_transfer/point_transfer_screen.dart';
import 'package:open_loyalty/view/points/PointBloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../point_transfer/p2p_point_transfer.dart';

class PointScreen extends StatefulWidget {
  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  final PointBloc pointBloc = PointBloc();
  final _repository = Repository();

  @override
  void initState() {
    super.initState();
    pointBloc.fetchCustomerStatus();
  }

  @override
  void dispose() {
    pointBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mSecondaryColor,
      body: StreamBuilder(
        stream: pointBloc.customerStatus,
        builder: (context, AsyncSnapshot<CustomerStatusModel> snapshot) {
          if (snapshot.hasData) {
            return buildData(snapshot.data);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildData(CustomerStatusModel? customerStatus) {
    return SingleChildScrollView(
      child: Column(
        children: [
          transactionAmount(customerStatus!),
          SizedBox(
            height: space_height,
          ),
          accumulated(customerStatus),
          SizedBox(
            height: space_height,
          ),
          pointAmount(customerStatus),
          SizedBox(
            height: space_height,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PointTransfer();
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Lịch sử điểm ",
                    style: TextStyle(fontSize: footnote, color: mPrimaryColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: footnote,
                    color: mPrimaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: space_height,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return P2PTransferPoint(customerStatus.points.toString());
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Chuyển điểm cho bạn bè",
                    style: TextStyle(fontSize: footnote, color: mPrimaryColor),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: footnote,
                    color: mPrimaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget pointAmount(CustomerStatusModel customerStatus) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        width: size.width,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Điểm",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: footnote, fontWeight: FontWeight.w500),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Tổng điểm",
                      style: TextStyle(
                          fontSize: footnote, color: Colors.grey[600]),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      customerStatus.totalEarnedPoints.toString(),
                      style: TextStyle(fontSize: footnote),
                      textAlign: TextAlign.end,
                    ))
              ],
            ),
            SizedBox(
              height: space_height * 2,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Điểm khả dụng",
                      style: TextStyle(
                          fontSize: footnote, color: Colors.grey[600])),
                ),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.points.toString(),
                        style: TextStyle(fontSize: footnote),
                        textAlign: TextAlign.end))
              ],
            ),
            SizedBox(
              height: space_height * 2,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text("Điểm đã sử dụng",
                      style: TextStyle(
                          fontSize: footnote, color: Colors.grey[600])),
                ),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.usedPoints.toString(),
                        style: TextStyle(fontSize: footnote),
                        textAlign: TextAlign.end))
              ],
            ),
            SizedBox(
              height: space_height * 2,
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("Điểm bị khoá",
                        style: TextStyle(
                            fontSize: footnote, color: Colors.grey[600]))),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.lockedPoints.toString(),
                        style: TextStyle(fontSize: footnote),
                        textAlign: TextAlign.end))
              ],
            ),
            SizedBox(
              height: space_height * 2,
            ),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text("Điểm hết hạn",
                        style: TextStyle(
                            fontSize: footnote, color: Colors.grey[600]))),
                Expanded(
                    flex: 2,
                    child: Text(customerStatus.expiredPoints.toString(),
                        style: TextStyle(fontSize: footnote),
                        textAlign: TextAlign.end))
              ],
            ),
          ],
        ));
  }

  Widget accumulated(CustomerStatusModel customerStatus) {
    Size size = MediaQuery.of(context).size;
    String amount = customerStatus.transactionsAmountToNextLevel.toString() +
        " " +
        customerStatus.currency;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        width: size.width,
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Quá trình tích luỹ",
                textAlign: TextAlign.left,
                style:
                TextStyle(fontSize: footnote, fontWeight: FontWeight.w500),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text(
                "Bạn cần thêm " + amount + " để thăng hạng",
                style: TextStyle(fontSize: footnote, color: Colors.grey),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
              Text(
                "Cấp độ tiếp theo " + customerStatus.nextLevel,
                style: TextStyle(fontSize: footnote, color: Colors.grey),
              )
            ]));
  }

  Widget transactionAmount(CustomerStatusModel customerStatus) {
    String totalTransaction = customerStatus.transactionsAmount.toString() +
        " " +
        customerStatus.currency;
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/images/crown.svg",
              height: size.height * 0.15,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(50, 0, 0, 15),
            alignment: Alignment.center,
            child: LinearPercentIndicator(
              width: 250,
              lineHeight: 24.0,
              percent: customerStatus.transactionsAmount /
                  customerStatus.transactionsAmountToNextLevel,
              center: Text(
                totalTransaction,
                style: new TextStyle(fontSize: footnote),
              ),
              trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey[300],
              progressColor: mLinear,
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              alignment: Alignment.center,
              child: Text(
                  "Cấp độ hiện tại" + " " + customerStatus.level.toString(),
                  style: TextStyle(fontSize: footnote)))
        ],
      ),
    );
  }
}
