import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/view/Schedule_Warranty/WarrantyBookingScreen.dart';
import 'package:open_loyalty/view/account_info/account_info_screen.dart';
import 'package:open_loyalty/view/booking_management/MaintenanceBookingManagement.dart';


class AccountScreen extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.only(top: space_height),
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Icon(
            Icons.person,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin tài khoản',
                style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AccountInfoScreen();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.construction,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin đăng ký bảo trì',
                style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MaintenanceBookingManagementScreen();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.business_center,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Thông tin đăng ký bảo hành',
                style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WarrantyBookingManagement();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.mail,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Hộp thư góp ý', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SupportRequestScreen();
                },
              ),
            );*/
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.assignment_rounded,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Hướng dẫn', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.settings,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Cài đặt', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.logout,
            size: mFontSize,
          ),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child: Text('Đăng xuất', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Divider(),
      ],
    );
  }
}
