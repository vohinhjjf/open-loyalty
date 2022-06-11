import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/view/account_screen/account_screen.dart';
import 'package:open_loyalty/view/campaign/components/coupon_bloc.dart';
import 'package:open_loyalty/view/card/card_screen.dart';
import 'package:open_loyalty/view/points/point_screen.dart';
import 'package:open_loyalty/view/transaction/transaction_screen.dart';
import '../../../../constant.dart';
import '../../Chat/MessagesPage.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

AppBar homeAppBar(BuildContext context) {
  Repository _repository = Repository();
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 0,
    title: const Text(
      "Admin",
      style: TextStyle(
          color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/bell.svg"),
        onPressed: () {
          print("click");
        },
      ),
    ],
  );
}

class _AdminScreenState extends State {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    MessagesPage(),
    TransactionScreen(),
    PointScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
            color: Colors.white10,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 5))
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Hỗ trợ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 18,
              ),
              label: 'Khách hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.feedback,
                size: 18,
              ),
              label: 'Phản hồi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Tài khoản',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mPrimaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 13,
          onTap: _onItemTapped,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
