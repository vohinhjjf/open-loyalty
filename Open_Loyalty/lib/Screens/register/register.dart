// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_loyalty/components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';

class RegisterScreen extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  final _auth = FirebaseAuth.instance;
  late DocumentSnapshot snapshot;
  bool loading = false;
  late String screen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String id = "";
    String name = '';
    late String email = "";
    late String password = "";
    String phone = "";

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "REGISTER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.orange,
                    )),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.orange,
                    )),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value1) {
                  email = value1;
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Password";
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.orange,
                    )),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    addUser(newUser.user!.uid, name, phone, email);
                    if (newUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  } catch (e) {
                    // ignore: avoid_print
                    print(e);
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                },
                child: const Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addUser(String id, String name, String phone, String email) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(id)
        .set({
          'id': id,
          'loyaltyCardNumber': randomNumber(),
          'email': email,
          'name': name,
          'sex': "sex",
          'birthday': "birthday",
          'nationality': "VIETNAM",
          'cmd': "",
          'number': phone,
          'location': "",
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String randomNumber() {
    var random = new Random();

    int min = 100000000;

    int max = 999999999;

    int result = random.nextInt(max - min);

    return result.toString();
  }
}
