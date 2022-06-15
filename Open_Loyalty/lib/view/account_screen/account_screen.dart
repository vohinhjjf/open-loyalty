import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/main.dart';
import 'package:open_loyalty/view/Schedule_Warranty/WarrantyBookingScreen.dart';
import 'package:open_loyalty/view/account_info/account_info_screen.dart';
import 'package:open_loyalty/view/booking_management/MaintenanceBookingManagement.dart';

import '../support_request/support_screen.dart';

class AccountScreen extends StatefulWidget {

  @override
  _AccountScreenState createState() => _AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Body(),
    );
  }
}
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;

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
    return user?.email == "admin@gmail.com"
      ? ListView(
      padding: EdgeInsets.only(top: space_height),
      children: <Widget>[
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.person,
            color: mPrimaryColor,
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
        ), //Tài khoản
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.logout,
            color: mPrimaryColor,
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
        ), // đăng xuất
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
      ],
    )
    : ListView(
      padding: EdgeInsets.only(top: space_height),
      children: <Widget>[
         ListTile(
          dense: true,
          leading: const Icon(
            Icons.person,
            color: mPrimaryColor,
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
        ), //Tài khoản
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.construction,
            color: mPrimaryColor,
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
        ), //bảo trì
         Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.business_center,
            color: mPrimaryColor,
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
        ), //bảo hành
         Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.mail,
            color: mPrimaryColor,
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
        ), // Góp ý
         Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.assignment_rounded,
            color: mPrimaryColor,
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
        ), // hướng dẫn
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.settings,
            color: mPrimaryColor,
            size: mFontSize,
          ),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: const Text('Cài đặt', style: TextStyle(fontSize: mFontSize)),
          ),
          onTap: () {
          },
        ), // cài đặt
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
        ListTile(
          dense: true,
          leading: const Icon(
            Icons.logout,
            color: mPrimaryColor,
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
        ), // đăng xuất
        Divider(height: 20,color: Colors.blue[100],indent: 20,endIndent: 20),
      ],
    );
  }

}
