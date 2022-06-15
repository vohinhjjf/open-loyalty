import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/view/campaign/components/voucher_detail.dart';

class CouponCard extends StatelessWidget {
  final String status;
  final String couponCode;
  final String activeSince;
  final String activeTo;
  final Color startColor;
  final Color endColor;
  final double _borderRadius = 24;

  const CouponCard(
      {Key? key,
        required this.activeSince,
        required this.activeTo,
        required this.couponCode,
        required this.endColor,
        required this.status,
        required this.startColor}):super(key: key);

  @override
  Widget build(BuildContext context) {
    String? status;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                gradient: LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: endColor,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter:
                    CustomCardShapePainter(_borderRadius, startColor, endColor),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: SvgPicture.asset(
                      "assets/images/present.svg",
                      height: 70,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          status == 'inactive'
                              ? 'Chưa kích hoạt'
                              : 'Đã kích hoạt',
                          style: TextStyle(
                              fontSize: footnote,
                              color: mPrimaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: space_height,
                        ),
                        Text(
                          "Thời gian hiệu lực: ",
                          style: TextStyle(fontSize: footnote),
                        ),
                        SizedBox(
                          height: space_height,
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(activeSince)),
                              style: TextStyle(
                                fontSize: footnote,
                              ),
                            ),
                            Text(" - "),
                            Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(activeTo)),
                                style: TextStyle(
                                  fontSize: footnote,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Code: ",
                              style: TextStyle(
                                fontSize: footnote,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              couponCode,
                              style: TextStyle(
                                  fontSize: footnote,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 28),
                            TextButton(
                                child: const Text(
                                  'Chi Tiết',
                                  style: TextStyle(color: mPrimaryColor),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return VoucherDetail(
                                          status == 'inactive'
                                              ? 'Chưa kích hoạt'
                                              : 'Đã kích hoạt',
                                          couponCode,
                                          DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(activeTo)));
                                    },
                                  ));
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
