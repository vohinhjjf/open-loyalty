import 'package:flutter/material.dart';
import 'package:open_loyalty/view/Dashboard/dashboard_screen.dart';
import 'package:open_loyalty/view/account_screen/account_screen.dart';
import 'package:open_loyalty/view/booking_management/MaintenanceBookingManagement.dart';
import 'Screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view/card/card_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => ProfileScreen(),
        '/account': (context) => AccountScreen(),
        '/maintenance': (context) => MaintenanceBookingManagementScreen(),
        '/card': (context) => CardScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State {
  //initialize Firebase
  Future _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const HomePage();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
