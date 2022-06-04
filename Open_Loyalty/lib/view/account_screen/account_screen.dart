import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/main.dart';
import 'package:open_loyalty/view/Schedule_Warranty/WarrantyBookingScreen.dart';
import 'package:open_loyalty/view/account_info/account_info_screen.dart';
import 'package:open_loyalty/view/booking_management/MaintenanceBookingManagement.dart';

import '../support_request/support_screen.dart';

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
          leading: const Icon(
            Icons.person,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Thông tin tài khoản',
                style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return  AccountInfoScreen();
                },
              ),
            );
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.construction,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Thông tin đăng ký bảo trì',
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
          leading: const Icon(
            Icons.business_center,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Thông tin đăng ký bảo hành',
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
          leading: const Icon(
            Icons.mail,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Hộp thư góp ý',
                style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SupportRequestScreen();
                },
              ),
            );
          },
        ),
         Divider(),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.assignment_rounded,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child:
                const Text('Hướng dẫn', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.settings,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Cài đặt', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {

          },
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.logout,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: Offset(-16, 0),
            child:
                const Text('Đăng xuất', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
        ),
        Divider(),
      ],
    );
  }

}
