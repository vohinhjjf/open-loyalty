import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/view/card/card_screen.dart';

import 'constant.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 0,
    title: Text(
      "Melodi",
      style: TextStyle(
          color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/bell.svg"),
        onPressed: () {},
      ),
    ],
  );
}
class _ProfileScreenState extends State {

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
  static List<Widget> _widgetOptions = <Widget>[
    CardScreen(),

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
                  offset: Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
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