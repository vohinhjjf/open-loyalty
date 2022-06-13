import 'package:bottom_bar/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/Firebase/locations.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/view/account_screen/account_screen.dart';
import 'package:open_loyalty/view/card/card_screen.dart';
import 'package:open_loyalty/view/points/point_screen.dart';
import 'package:open_loyalty/view/transaction/transaction_screen.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import '../../constant.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

AppBar homeAppBar(BuildContext context, int value) {
  String name;
  Repository _repository = Repository();
  switch (value) {
    case 0: {
      name = 'Trang chủ';
      break;
    }
    case 1: {
      name = 'Lịch sử';
      break;
    }
    case 2: {
      name = 'Điểm thưởng';
      break;
    }
    default :{
      name = 'Tài khoản';
      break;
    }
  }
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 0,
    title: Text(
      name,
      style: const TextStyle(
          color: mPrimaryColor, fontSize: mFontTitle, fontWeight: FontWeight.w600),
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

  final List<Widget> _widgetOptionsAdmin = <Widget>[
    CardScreen(),
    AccountScreen()
  ];
  final List<Widget> _widgetOptions = <Widget>[
    CardScreen(),
    TransactionScreen(),
    PointScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    PageController pageController = PageController();
    return
      user?.email == "admin@gmail.com"
          ?  Scaffold(
            appBar: homeAppBar(context, _selectedIndex),
            body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: _widgetOptionsAdmin
            ),
            bottomNavigationBar:
              WaterDropNavBar(
              backgroundColor: Colors.white,
              waterDropColor: mPrimaryColor,
              bottomPadding: 10,
              onItemSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                pageController.animateToPage(_selectedIndex,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              },
              selectedIndex: _selectedIndex,
              barItems: [
                BarItem(
                  filledIcon: Icons.home,
                  outlinedIcon: Icons.home_outlined,
                ),
                BarItem(
                    filledIcon: Icons.account_circle,
                    outlinedIcon: Icons.account_circle_outlined
                ),
              ],
            ),
          )
          :  Scaffold(
          appBar: homeAppBar(context, _selectedIndex),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children:_widgetOptions,
          ),
          bottomNavigationBar:
          BottomBar(
            selectedIndex: _selectedIndex,
            onTap: (int index) {
              pageController.jumpToPage(index);
              setState(() => _selectedIndex = index);
            },
            items: const <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home),
                title: Text('Trang chủ'),
                activeColor: mPrimaryColor,
              ),
              BottomBarItem(
                icon: Icon(Icons.access_time),
                title: Text('Lịch sử'),
                activeColor: mPrimaryColor,
              ),
              BottomBarItem(
                icon: Icon(Icons.star_border),
                title: Text('Điểm thưởng'),
                activeColor: mPrimaryColor,
              ),
              BottomBarItem(
                icon: Icon(Icons.account_circle_outlined),
                title: Text('Tài khoản'),
                activeColor: mPrimaryColor,
              ),
            ],
          ),

      );
  }
}

