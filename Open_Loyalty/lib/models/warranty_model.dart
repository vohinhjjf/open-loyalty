import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_loyalty/Firebase/user_data.dart';
import 'package:open_loyalty/models/maintenance.dart';

class ListWarrantyModel {
  int? total;
  List<WarrantyModel> warrantyModels = [];

  ListWarrantyModel({required this.warrantyModels, this.total});

}

class WarrantyModel {
  late String maintenanceId;
  late String productSku;
  late DateTime bookingDate;
  late String bookingTime;
  late String warrantyCenter;
  late DateTime createdAt;
  late bool active;
  late String discription;
  late String cost;
  late String paymentStatus;

}
Future<String?> bookingWarranty(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
    ) async {
  User? user = FirebaseAuth.instance.currentUser;
  final docSnapshot = await FirebaseFirestore.instance.collection('Users').doc(user?.uid).get();
  final select = await FirebaseFirestore.instance.collection('Warranty').doc(user?.uid).get();
  var i;
  if (select.exists) {
    Map<String, dynamic> data_select = select.data()!;
    i = data_select.length;
    print(i);
  }
  String email, name, phone, loyaltyCardNumber;
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    email = data['email'];
    name = data['name'];
    phone = data['number'];
    loyaltyCardNumber = data['loyaltyCardNumber'];
    var warranty_data = {
      "warranty $i": {
        "warrantyData": {
          "productSku": productSku,
          "bookingDate": bookingDate.toIso8601String(),
          "bookingTime": bookingTime,
          "warrantyCenter": warrantyCenter,
          "createdAt": createAt.toIso8601String(),
          "description": "test",
          "cost": "1.000.000",
          "paymentStatus": "unpaid",
          "active": true
        },
        "customerData": {
          "email": email,
          "name": name,
          "nip": "aaa",
          "phone": phone,
          "loyaltyCardNumber": loyaltyCardNumber,
        }
      }
    };
    FirebaseFirestore.instance.collection('Warranty').doc(user?.uid).update(warranty_data)
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add user: $error"));
    return 'succes';
  }
}

Future<String?> booking(
    String productSku,
    String warrantyCenter,
    DateTime bookingDate,
    String bookingTime,
    DateTime createAt,
    ) async {
  User? user = FirebaseAuth.instance.currentUser;
  final docSnapshot = await FirebaseFirestore.instance.collection('Users').doc(user?.uid).get();
  final select = await FirebaseFirestore.instance.collection('Maintenance').doc(user?.uid).get();
  var i;
  if (select.exists) {
    Map<String, dynamic> data_select = select.data()!;
    i = data_select.length;
    print(i);
  }
  String email, name, phone, loyaltyCardNumber;
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    email = data['email'];
    name = data['name'];
    phone = data['number'];
    loyaltyCardNumber = data['loyaltyCardNumber'];
    var maintenance_data = {
      "maintenance $i": {
        "maintenanceData": {
          "productSku": productSku,
          "bookingDate": bookingDate.toIso8601String(),
          "bookingTime": bookingTime,
          "warrantyCenter": warrantyCenter,
          "createdAt": createAt.toIso8601String(),
          "description": "test",
          "cost": "1.000.000",
          "paymentStatus": "unpaid",
          "active": true
        },
        "customerData": {
          "email": email,
          "name": name,
          "nip": "aaa",
          "phone": phone,
          "loyaltyCardNumber": loyaltyCardNumber,
        }
      }
    };
    FirebaseFirestore.instance.collection('Maintenance').doc(user?.uid).update(maintenance_data)
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add user: $error"));
    return 'succes';
  }
}