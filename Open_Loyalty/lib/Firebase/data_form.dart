import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_loyalty/Firebase/firebase_realtime_data_service.dart';
import 'package:open_loyalty/Firebase/user_data.dart';

class DataForm {
  String collection = 'Users';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String? userName;
  Future<String?> showDisplayName() async {
    var collection = FirebaseFirestore.instance.collection('Users');
    //userUid is the current auth user
    var docSnapshot = await collection.doc('0DZsYLFmNwCti6sasm37').get();

    Map<String, dynamic> data = docSnapshot.data()!;

    userName = data['name'];
    return userName;
  }
  //create new user
  Future<void> createUserData(Map<String, dynamic> values) async {
    String id = values['id'];
    await _firestore.collection(collection).doc(id).set(values);
  }

  //update user data
  Future<void> updateUserData(Map<String, dynamic> values) async {
    String id = values['id'];
    await _firestore.collection(collection).doc(id).update(values);
  }

  //get user data by User id
  Future<String> getUserById(String id) async {
    String userName;
    var collection = FirebaseFirestore.instance.collection('Users');
    //userUid is the current auth user
    var docSnapshot = await collection.doc(id).get();

    Map<String, dynamic> data = docSnapshot.data()!;

    userName = data['name'];
    return userName;
  }
}
