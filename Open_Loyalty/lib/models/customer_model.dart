import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_loyalty/constant.dart';

class CustomerModel {
  late String id;
  late String name;
  late String gender;
  late String birthday;
  late String nationality;
  late String cmd;
  late String phone;
  late String email;
  late String loyaltyCardNumber;
  late String levelId;
  late String location;

  CustomerModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.nationality,
    required this.cmd,
    required this.phone,
    required this.email,
    required this.loyaltyCardNumber,
    required this.levelId,
    required this.location,
  });

  Map<String, String> toJson() {
    return {
      FirestoreConstants.name: name,
      FirestoreConstants.email: email,
    };
  }

  factory CustomerModel.fromDocument(DocumentSnapshot doc) {
    String email = "";
    String name = "";
    String gender = "";
    String birthday = "";
    String nationality = "";
    String cmd = "";
    String phone = "";
    String loyaltyCardNumber = "";
    String levelId = "";
    String location = "";
    Map<String, dynamic> data = doc.get(['information'][0]);
    return CustomerModel(
      id: doc.id,
      name: data['name'] as String,
      gender: gender,
      birthday: birthday,
      nationality: nationality,
      cmd: cmd,
      phone: phone,
      email: data['email'] as String,
      loyaltyCardNumber: loyaltyCardNumber,
      levelId: levelId,
      location: location,
    );
  }
}

class CustomerStatusModel {
  late double points;
  late double p2pPoints;
  late double totalEarnedPoints;
  late double usedPoints;
  late double expiredPoints;
  late double lockedPoints;
  late String level;
  late String levelName;
  late double levelConditionValue;
  late String nextLevel;
  late String nextLevelName;
  late double nextLevelConditionValue;
  late double transactionsAmountWithoutDeliveryCosts;
  late double transactionsAmountToNextLevel;
  late double averageTransactionsAmount;
  late int transactionsCount;
  late double transactionsAmount;
  late String currency;
  late double pointsExpiringNextMonth;
}
