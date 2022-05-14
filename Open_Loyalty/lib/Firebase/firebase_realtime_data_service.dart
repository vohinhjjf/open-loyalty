import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/models/maintenance.dart';
import 'package:open_loyalty/models/point_model.dart';
import 'package:open_loyalty/models/warranty_model.dart';

class CustomerApiProvider {

  User? user = FirebaseAuth.instance.currentUser;
  var customer = FirebaseFirestore.instance.collection('Users');
  var point = FirebaseFirestore.instance.collection('Points');
  var campaign = FirebaseFirestore.instance.collection('Campaigns');
  var warranty = FirebaseFirestore.instance.collection('Warranty');
  var maintenance = FirebaseFirestore.instance.collection('Maintenance');

  Future<void> addUser(
      CollectionReference users,
      String id,
      String name,
      String phone,
      String email,
      String loyaltyCardNumber
      ) {
    maintenance.doc(id).set({});
    warranty.doc(id).set({});
    FirebaseFirestore.instance.collection('Products').doc(id).set({});
    point.doc(id).set({});
    campaign.doc(id).collection("available").add({
      "name": 'Inactive',
      "campaignId": '0'+'23456789',
      "reward": 'reward',
      "active": true,
      "costInPoints": 0,
      "singleCoupon": true,
      "unlimited": true,
      "limit": 0,
      "limitPerUser": 0,
      "daysInactive": 0,
      "daysValid": 0,
      "featured": true,
      "public": true,
      "usageLeft": 0,
      "usageLeftForCustomer": 0,
      "canBeBoughtByCustomer": true,
      "visibleForCustomersCount": 0,
      "usersWhoUsedThisCampaignCount":0,
    });
    // Call the user's CollectionReference to add a new user
    return users
        .doc(id)
        .set({
      'information':{
        'userId': id,
        'loyaltyCardNumber': loyaltyCardNumber,
        'email': email,
        'name': name,
        'gender': "",
        'birthday': "birthday",
        'nationality': "VIETNAM",
        'cmd': "",
        'number': phone,
        'levelId': '',
        'location': "",
      },
      'status':{
        'averageTransactionsAmount':10.0,
        'currency': 'currency',
        'expiredPoints': 10.0,
        'level': 'level',
        'levelConditionValue': 10.0,
        'levelName': 'levelName',
        'lockedPoints':10.0,
        'nextLevel':'nextLevel',
        'nextLevelConditionValue':10.0,
        'nextLevelName':'nextLevelName',
        'p2pPoints':10.0,
        'points':10.0,
        'pointsExpiringNextMonth':10.0,
        'totalEarnedPoints':10.0,
        'transactionsAmount':10.0,
        'transactionsAmountToNextLevel':10.0,
        'transactionsAmountWithoutDeliveryCosts':10.0,
        'transactionsCount':1,
        'usedPoints':10.0
      }
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<CustomerModel?> getUser() async {
    var docSnapshot = await customer.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from the Map like this:

      CustomerModel customerModel = new CustomerModel(id: '', name: '', phone: '', email: '', birthday: '', gender: '', location: '', cmd: '', nationality: '', loyaltyCardNumber: '', levelId: '');
      customerModel.id = data['information']['id'];
      customerModel.name = data['information']['name'];
      customerModel.gender = data['information']['sex'];
      customerModel.birthday = data['information']['birthday'];
      customerModel.nationality = data['information']['nationality'];
      customerModel.cmd = data['information']['cmd'];
      customerModel.phone = data['information']['number'];
      customerModel.email = data['information']['email'];
      customerModel.loyaltyCardNumber = data['information']['loyaltyCardNumber'];
      customerModel.levelId = data['information']['levelId'];
      customerModel.location = data['information']['location'];
      return customerModel;
    }
  }

  Future<CustomerStatusModel?> fetchCustomerStatus() async {
    var docSnapshot = await customer.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from the Map like this:

      CustomerStatusModel customerStatusModel = new CustomerStatusModel(averageTransactionsAmount: 10.0, currency: '', expiredPoints: 10.0, level: '', levelConditionValue: 10.0, levelName: '', lockedPoints: 10.0, nextLevel: '', nextLevelConditionValue: 10.0, nextLevelName: '', p2pPoints: 10.0, points: 10.0, pointsExpiringNextMonth: 10.0, totalEarnedPoints: 10.0, transactionsAmount: 10.0, transactionsAmountToNextLevel: 10.0, transactionsAmountWithoutDeliveryCosts: 10.0, transactionsCount: 0, usedPoints: 10.0);
      customerStatusModel.averageTransactionsAmount = data['status']['averageTransactionsAmount'];
      customerStatusModel.currency = data['status']['currency'];
      customerStatusModel.expiredPoints = data['status']['expiredPoints'];
      customerStatusModel.level = data['status']['level'];
      customerStatusModel.levelConditionValue = data['status']['levelConditionValue'];
      customerStatusModel.nextLevelName = data['status']['nextLevelName'];
      customerStatusModel.p2pPoints = data['status']['p2pPoints'];
      customerStatusModel.pointsExpiringNextMonth = data['status']['pointsExpiringNextMonth'];
      customerStatusModel.totalEarnedPoints = data['status']['totalEarnedPoints'];
      customerStatusModel.transactionsAmount = data['status']['transactionsAmount'];
      customerStatusModel.transactionsAmountWithoutDeliveryCosts = data['status']['transactionsAmountWithoutDeliveryCosts'];
      customerStatusModel.transactionsCount = data['status']['transactionsCount'];
      customerStatusModel.usedPoints = data['status']['usedPoints'];
      return customerStatusModel;
    }
  }

  //fetch list point transfer
  Future<ListPointTransferModel> fetchCustomerPointTransfer() async {
    var docSnapshot = await point.doc(user?.uid).get();
    List<PointTransferModel> temp = [];
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var length = data.length;
      for(int i =0; i< length; i++) {
        PointTransferModel trans1 =new PointTransferModel();
        trans1.value =  data['Point $i']["value"] as double;
        trans1.pointsTransferId = data['Point $i']["pointsTransferId"];
        trans1.accountId = data['Point $i']["accountId"];
        trans1.comment = data['Point $i']["comment"];
        trans1.customerId = data['Point $i']["customerId"];
        trans1.createdAt = DateTime.parse(data['Point $i']["createdAt"]);
        trans1.issuer =data['Point $i']["issuer"];
        trans1.expiresAt = DateTime.parse(data['Point $i']["expiresAt"]);
        trans1.state = data['Point $i']["state"];
        trans1.type = data['Point $i']["type"];
        temp.add(trans1);
      }
    }
    return ListPointTransferModel(pointTransferModels: temp, total: temp.length);
  }

  Future<void> setCustomerPointTransfer() async {
    final select = await point.doc(user?.uid).get();
    if (select.exists) {
      Map<String, dynamic> data_select = select.data()!;
      var i = data_select.length;
      var maintenance_data = {
        "Point $i": {
          "customerId": '$i',
          "pointsTransferId": 'bookingDate.toIso8601String()',
          "accountId": 'bookingTime',
          "expiresAt": '2022-05-13T12:00:00.000Z',
          "createdAt": '2022-05-13T12:00:00.000Z',
          "value": i.toDouble(),
          "state": "1$i.000.000",
          "type": "adding",
          "comment": 'comment',
          "issuer":"issuer"
        }
      };
      return FirebaseFirestore.instance.collection('Points').doc(user?.uid).update(
          maintenance_data)
          .then((value) => print("Points Update"))
          .catchError((error) => print("Failed to add user: $error"));
    }
  }

  //fetch customer campaign
  Future<ListCampaignModel?> fetchCustomerCampaign() async {
    List<CampaignModel> _newList = [];
    QuerySnapshot snapshot = await campaign.doc(user?.uid).collection("available").get();
    snapshot.docs.forEach((doc) {
      if(!_newList.contains(doc.data())){
        CampaignModel couponModel = new CampaignModel(doc.data());
        _newList.add(couponModel);
      }

    });
    return ListCampaignModel(campaignModels: _newList, total: _newList.length);
  }

  Future<void> setCustomerCampaign() async {
    print('available');
    var id = user?.uid;
    final select = await campaign.doc(id).collection("available").get();
    var i = select.size;
    var available_data = {
      "name": 'campaign $i',
      "campaignId": '$i'+'23456789',
      "reward": 'reward',
      "active": true,
      "costInPoints": i,
      "singleCoupon": true,
      "unlimited": true,
      "limit": i,
      "limitPerUser": i,
      "daysInactive": i,
      "daysValid": i,
      "featured": true,
      "public": true,
      "usageLeft": i,
      "usageLeftForCustomer": i,
      "canBeBoughtByCustomer": true,
      "visibleForCustomersCount": i,
      "usersWhoUsedThisCampaignCount":i,
    };
    return campaign.doc(id).collection("available").add(
        available_data)
        .then((value) => print("Points Update"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //buy coupon(campaign)
  dynamic buyCoupon(String couponId, String costInPoints) async {
    print("entered");
    var id = user?.uid;
    String dateStart = '22-04-2021 05:57:58 PM';
    DateFormat inputFormat = DateFormat('dd-MM-yyyy hh:mm:ss a');
    DateTime input = inputFormat.parse(dateStart);
    var bought_data = {
      "canBeUsed": false,
      "campaignId": couponId,
      "purchaseAt": '2022-05-13T12:00:00.000Z',
      "costInPoints": double.tryParse(costInPoints),
      "used": false,
      "coupon": {
        "id": '023456789',
        "code":'ABCDEF',
      },
      "status": 'inactive',
      "activeSince": DateTime.now().toString(),
      "activeTo": input.toString(),
      "deliveryStatus": '0'
    };
    return campaign.doc(id).collection("bought").add(bought_data);
  }

  //fetch customer coupon
  Future<ListCouponModel> fetchCustomerCoupon() async {
    List<CouponModel> _newList = [];
    QuerySnapshot snapshot = await campaign.doc(user?.uid).collection("bought").get();
    snapshot.docs.forEach((doc) {
      if(!_newList.contains(doc.data())){
        CouponModel couponModel = new CouponModel(doc.data());
        _newList.add(couponModel);
      }

    });
    return ListCouponModel(couponModel: _newList, total: _newList.length);
  }


  //Maintenance
  Future<ListMaintenanceModel_1> fetchCustomerMaintenanceBooking() async {
    var docSnapshot = await maintenance.doc(user?.uid).get();
    List<MaintenanceModel_1> temp = [];

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var length = data.length;
      for(int i =0; i< length; i++) {
        MaintenanceModel_1 trans1 =new MaintenanceModel_1();
        trans1.maintenanceId = "$i";
        trans1.productSku = data['maintenance $i']['productSku'];
        trans1.bookingDate = DateTime.parse(data['maintenance $i']['bookingDate']).toLocal();
        trans1.bookingTime = data['maintenance $i']['bookingTime'];
        trans1.warrantyCenter = data['maintenance $i']['warrantyCenter'];
        trans1.createdAt = DateTime.parse(data['maintenance $i']['createdAt']);
        trans1.active = data['maintenance $i']['active'];
        trans1.discription = data['maintenance $i']['description'];
        trans1.cost = data['maintenance $i']['cost'];
        trans1.paymentStatus = data['maintenance $i']['paymentStatus'];
        temp.add(trans1);
      }
    }
    return ListMaintenanceModel_1(maintenanceModels: temp, total: temp.length);
  }
  //Warranty
  Future<ListWarrantyModel> fetchCustomerWarrantyBooking() async {
    var docSnapshot = await warranty.doc(user?.uid).get();
    List<WarrantyModel> temp = [];
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      var length = data.length;
      for(int i = 0; i< length; i++) {
        WarrantyModel trans =new WarrantyModel();
        trans.maintenanceId = "$i";
        trans.productSku = data['warranty $i']['productSku'];
        trans.bookingDate = DateTime.parse(data['warranty $i']['bookingDate']).toLocal();
        trans.bookingTime = data['warranty $i']['bookingTime'];
        trans.warrantyCenter = data['warranty $i']['warrantyCenter'];
        trans.createdAt = DateTime.parse(data['warranty $i']['createdAt']);
        trans.active = data['warranty $i']['active'];
        trans.discription = data['warranty $i']['description'];
        trans.cost = data['warranty $i']['cost'];
        trans.paymentStatus = data['warranty $i']['paymentStatus'];
        temp.add(trans);
      }
    }
    return ListWarrantyModel(warrantyModels: temp, total: temp.length);

  }

  Future<String?> bookingWarranty(
      String productSku,
      String warrantyCenter,
      DateTime bookingDate,
      String bookingTime,
      DateTime createAt,
      ) async {
    final select = await warranty.doc("user?.uid").get();
    if (select.exists) {
      Map<String, dynamic> data_select = select.data()!;
      var i = data_select.length;
      var warranty_data = {
        "warranty $i": {
          "productSku": productSku,
          "bookingDate": bookingDate.toIso8601String(),
          "bookingTime": bookingTime,
          "warrantyCenter": warrantyCenter,
          "createdAt": createAt.toIso8601String(),
          "description": "test",
          "cost": "1.000.000",
          "paymentStatus": "unpaid",
          "active": true
        }
      };
      warranty.doc(user?.uid).update(
          warranty_data)
          .then((value) => print("Warranty Update"))
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
    final select = await maintenance.doc(user?.uid).get();
    if (select.exists) {
      Map<String, dynamic> data_select = select.data()!;
      var i = data_select.length;
      var maintenance_data = {
        "maintenance $i": {
          "productSku": productSku,
          "bookingDate": bookingDate.toIso8601String(),
          "bookingTime": bookingTime,
          "warrantyCenter": warrantyCenter,
          "createdAt": createAt.toIso8601String(),
          "description": "test",
          "cost": "1.000.000",
          "paymentStatus": "unpaid",
          "active": true
        }
      };
      maintenance.doc(user?.uid).update(
          maintenance_data)
          .then((value) => print("Maintenance Update"))
          .catchError((error) => print("Failed to add user: $error"));
      return 'succes';
    }
  }
}


