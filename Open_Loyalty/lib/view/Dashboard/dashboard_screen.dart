import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/Firebase/locations.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/view/account_screen/account_screen.dart';
import 'package:open_loyalty/view/campaign/components/coupon_bloc.dart';
import 'package:open_loyalty/view/card/card_screen.dart';
import 'package:open_loyalty/view/points/point_screen.dart';
import 'package:open_loyalty/view/transaction/transaction_screen.dart';
import '../../constant.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 0,
    title: const Text(
      "Melodi",
      style: TextStyle(
          color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/bell.svg"),
        onPressed: () {
          getStores();
        },
      ),
    ],
  );
}

class _ProfileScreenState extends State {
  int _selectedIndex = 0;
  Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
    _repository.setStores();
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
    CardScreen(),
    TransactionScreen(),
    PointScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.credit_card_outlined),
              label: 'Thẻ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
                size: 18,
              ),
              label: 'Lịch sử',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.star_border,
                size: 18,
              ),
              label: 'Điểm thưởng',
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

