import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Office {
  late String address;
  late String id;
  late double lat;
  late double lng;
  late String name;
  late double distance;

  Office(office) {
    address = office["address"];
    id = office["id"];
    lat = office["lat"];
    lng = office["lng"];
    name = office["name"];
  }
}
late Position currentPosition;
class Locations {
  final size = 3;
  List<Office> offices = [];

  Locations(data) {
    List<Office> temp = [];

    for (int i = 0; i < size; i++) {
      Office office = Office(data["offices $i"]);
      double distance = (Geolocator.distanceBetween(office.lat, office.lng,
          currentPosition.latitude, currentPosition.longitude) /
          1000);
      office.distance = double.parse(distance.toStringAsFixed(2));
      temp.add(office);
    }
    offices = temp;

    //sort theo thu tu gan den xa
    Comparator<Office> sortByDistance =
        (a, b) => a.distance.compareTo(b.distance);
    offices.sort(sortByDistance);
  }
}

void setCurrentPosition(Position cur) {
  currentPosition = cur;
}

Future<Locations> getStores() async {
  var docSnapshot = await FirebaseFirestore.instance.collection('Location').doc('store').get();
  late Locations stores;
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    stores = Locations(data);
  };
  print(stores.offices.length);
  return stores;
}


