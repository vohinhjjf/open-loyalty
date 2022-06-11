import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/models/maintenance.dart';
import 'package:open_loyalty/models/point_model.dart';
import 'package:open_loyalty/models/warranty_model.dart';
import 'package:open_loyalty/view/point_transfer/p2p_point_transfer.dart';

import '../models/request_support_model.dart';

class CustomerApiProvider {
  User? user = FirebaseAuth.instance.currentUser;
  var customer = FirebaseFirestore.instance.collection('Users');
  var point = FirebaseFirestore.instance.collection('Points');
  var campaign = FirebaseFirestore.instance.collection('Campaigns');
  var warranty = FirebaseFirestore.instance.collection('Warranty');
  var maintenance = FirebaseFirestore.instance.collection('Maintenance');
  var string;
  //User
  Future<void> addUser(CollectionReference users, String id, String name,
      String phone, String email, String loyaltyCardNumber) {
    maintenance.doc(id).set({});
    warranty.doc(id).set({});
    FirebaseFirestore.instance.collection('Products').doc(id).set({});
    //point.doc(id).set({});
    setCustomerPointTransfer(10.0, 'newuser', 'adding', id);
    campaign.doc(id).collection("available").add({
      "name": 'Inactive',
      "campaignId": '0' + '23456789',
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
      "usersWhoUsedThisCampaignCount": 0,
    });
    // Call the user's CollectionReference to add a new user
    return users
        .doc(id)
        .set({
          'information': {
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
          'status': {
            'averageTransactionsAmount': 10.0,
            'currency': 'điểm',
            'expiredPoints': 0.0,
            'level': '1',
            'levelConditionValue': 10.0,
            'levelName': '1',
            'lockedPoints': 0.0,
            'nextLevel': '2',
            'nextLevelConditionValue': 50.0,
            'nextLevelName': '2',
            'p2pPoints': 0.0,
            'points': 10.0,
            'pointsExpiringNextMonth': 0.0,
            'totalEarnedPoints': 10.0,
            'transactionsAmount': 10.0,
            'transactionsAmountToNextLevel': 40.0,
            'transactionsAmountWithoutDeliveryCosts': 10.0,
            'transactionsCount': 0,
            'usedPoints': 0.0
          }
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<CustomerModel?> getUser() async {
    var docSnapshot = await customer.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from Firebase like this:

      CustomerModel customerModel = new CustomerModel(
          id: '',
          name: '',
          phone: '',
          email: '',
          birthday: '',
          gender: '',
          location: '',
          cmd: '',
          nationality: '',
          loyaltyCardNumber: '',
          levelId: '');
      customerModel.id = data['information']['id'];
      customerModel.name = data['information']['name'];
      customerModel.gender = data['information']['sex'];
      customerModel.birthday = data['information']['birthday'];
      customerModel.nationality = data['information']['nationality'];
      customerModel.cmd = data['information']['cmd'];
      customerModel.phone = data['information']['number'];
      customerModel.email = data['information']['email'];
      customerModel.loyaltyCardNumber =
          data['information']['loyaltyCardNumber'];
      customerModel.levelId = data['information']['levelId'];
      customerModel.location = data['information']['location'];
      return customerModel;
    }
  }

  Future<CustomerStatusModel?> fetchCustomerStatus() async {
    var docSnapshot = await customer.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      // You can then retrieve the value from Firebase like this:

      CustomerStatusModel customerStatusModel = CustomerStatusModel();
      customerStatusModel.averageTransactionsAmount =
          data['status']['averageTransactionsAmount'];
      customerStatusModel.currency = data['status']['currency'];
      customerStatusModel.expiredPoints = data['status']['expiredPoints'];
      customerStatusModel.level = data['status']['level'];
      customerStatusModel.levelConditionValue =
          data['status']['levelConditionValue'];
      customerStatusModel.levelName = data['status']['levelName'];
      customerStatusModel.lockedPoints = data['status']['lockedPoints'];
      customerStatusModel.nextLevel = data['status']['nextLevel'];
      customerStatusModel.nextLevelConditionValue =
          data['status']['nextLevelConditionValue'];
      customerStatusModel.nextLevelName = data['status']['nextLevelName'];
      customerStatusModel.p2pPoints = data['status']['p2pPoints'];
      customerStatusModel.points = data['status']['points'];
      customerStatusModel.pointsExpiringNextMonth =
          data['status']['pointsExpiringNextMonth'];
      customerStatusModel.totalEarnedPoints =
          data['status']['totalEarnedPoints'];
      customerStatusModel.transactionsAmount =
          data['status']['transactionsAmount'];
      customerStatusModel.transactionsAmountToNextLevel =
          data['status']['transactionsAmountToNextLevel'];
      customerStatusModel.transactionsAmountWithoutDeliveryCosts =
          data['status']['transactionsAmountWithoutDeliveryCosts'];
      customerStatusModel.transactionsCount =
          data['status']['transactionsCount'];
      customerStatusModel.usedPoints = data['status']['usedPoints'];
      return customerStatusModel;
    }
  }

  //fetch list point transfer
  Future<ListPointTransferModel> fetchCustomerPointTransfer() async {
    List<PointTransferModel> temp = [];
    QuerySnapshot snapshot =
        await point.doc(user?.uid).collection('point').get();
    snapshot.docs.forEach((doc) {
      if (!temp.contains(doc.data())) {
        PointTransferModel trans1 = new PointTransferModel(doc.data());
        temp.add(trans1);
      }
    });

    return ListPointTransferModel(
        pointTransferModels: temp, total: temp.length);
  }

  Future<void> setCustomerPointTransfer(
      double value, String comment, String type, String? id) async {
    final select = await point.doc(id).collection('point').get();
    var i = select.size;
    var pointtransfer_data = {
      "customerId": user?.uid,
      "pointsTransferId": 'bookingDate.toIso8601String()',
      "accountId": '$i',
      "expiresAt": '2023-05-13T12:00:00.000Z',
      "createdAt": DateTime.now().toString(),
      "value": value,
      "state": "$i.000.000",
      "type": type,
      "comment": comment,
      "issuer": "issuer"
    };
    return point
        .doc(id)
        .collection('point')
        .add(pointtransfer_data)
        .then((value) => print("Points Update"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  //point tranfer
  Future<String?> pointTransfer(String receiver, double points) async {
    final list_id = <String>[];
    final list_phone = <String>[];
    final data = {
      "transfer": {
        "receiver": receiver,
        "points": points,
      }
    };
    var st;
    QuerySnapshot id = await customer.get();
    id.docs.forEach((doc) {
      list_id.add(doc.id);
    });
    for (int i = 0; i < list_id.length; i++) {
      final docSnapshot = await customer.doc(list_id[i]).get();
      var phone;
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        phone = data['information']['number'];
        list_phone.add(phone);
      }
    }
    for (int j = 0; j < list_phone.length; j++) {
      if (receiver == list_phone[j]) {
        point
            .doc(user?.uid)
            .collection('p2p_tranfer')
            .add(data)
            .then((value) => print("p2p_tranfer Update"))
            .catchError((error) => print("Failed to add p2p_tranfer: $error"));
        st = 'success';
      }
    }
    return st;
  }

  //Update point
  Future<void> UpdatePointSender(String comment, double points) async {
    var docSnapshot = await customer.doc(user?.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      CustomerStatusModel customerStatusModel = CustomerStatusModel();
      customerStatusModel.p2pPoints = data['status']['p2pPoints'];
      customerStatusModel.points = data['status']['points'];
      customerStatusModel.transactionsAmount =
          data['status']['transactionsAmount'];
      customerStatusModel.transactionsAmountToNextLevel =
          data['status']['transactionsAmountToNextLevel'];
      customerStatusModel.transactionsAmountWithoutDeliveryCosts =
          data['status']['transactionsAmountWithoutDeliveryCosts'];
      customerStatusModel.transactionsCount =
          data['status']['transactionsCount'];
      customerStatusModel.usedPoints = data['status']['usedPoints'];
      final upate_point = {
        'status': {
          'averageTransactionsAmount': 10.0,
          'currency': 'điểm',
          'expiredPoints': 0.0,
          'level': '1',
          'levelConditionValue': 10.0,
          'levelName': '1',
          'lockedPoints': 0.0,
          'nextLevel': '2',
          'nextLevelConditionValue': 50.0,
          'nextLevelName': '2',
          'p2pPoints': points,
          'points': customerStatusModel.transactionsAmount - points,
          'pointsExpiringNextMonth': 0.0,
          'totalEarnedPoints': 10.0,
          'transactionsAmount': customerStatusModel.transactionsAmount - points,
          'transactionsAmountToNextLevel':
              customerStatusModel.transactionsAmountToNextLevel + points,
          'transactionsAmountWithoutDeliveryCosts':
              customerStatusModel.transactionsAmount - points,
          'transactionsCount': customerStatusModel.transactionsCount + 1,
          'usedPoints': points
        }
      };
      setCustomerPointTransfer(points, comment, 'using', user?.uid);
      return customer.doc(user?.uid).update(upate_point);
    }
  }

  Future<void> UpdatePointReceiver(String comment, double points) async {
    final list_id = <String>[];
    var id_receiver, phone;
    QuerySnapshot id = await customer.get();
    id.docs.forEach((doc) {
      list_id.add(doc.id);
    });
    for (int i = 0; i < list_id.length; i++) {
      final docSnapshot = await customer.doc(list_id[i]).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        phone = data['information']['number'];
        if (comment == phone) {
          id_receiver = list_id[i];
        }
      }
    }
    final docSnapshotsender = await customer.doc(user?.uid).get();
    if (docSnapshotsender.exists) {
      Map<String, dynamic> data = docSnapshotsender.data()!;
      phone = data['information']['number'];
    }
    var docSnapshotreceiver = await customer.doc(id_receiver).get();
    if (docSnapshotreceiver.exists) {
      Map<String, dynamic> data = docSnapshotreceiver.data()!;
      CustomerStatusModel customerStatusModel = CustomerStatusModel();
      customerStatusModel.p2pPoints = data['status']['p2pPoints'];
      customerStatusModel.points = data['status']['points'];
      customerStatusModel.totalEarnedPoints =
          data['status']['totalEarnedPoints'];
      customerStatusModel.transactionsAmount =
          data['status']['transactionsAmount'];
      customerStatusModel.transactionsAmountToNextLevel =
          data['status']['transactionsAmountToNextLevel'];
      customerStatusModel.transactionsAmountWithoutDeliveryCosts =
          data['status']['transactionsAmountWithoutDeliveryCosts'];
      customerStatusModel.transactionsCount =
          data['status']['transactionsCount'];
      customerStatusModel.usedPoints = data['status']['usedPoints'];
      final upate_point = {
        'status': {
          'averageTransactionsAmount': 10.0,
          'currency': 'điểm',
          'expiredPoints': 0.0,
          'level': '1',
          'levelConditionValue': 10.0,
          'levelName': '1',
          'lockedPoints': 0.0,
          'nextLevel': '2',
          'nextLevelConditionValue': 50.0,
          'nextLevelName': '2',
          'p2pPoints': points,
          'points': customerStatusModel.transactionsAmount + points,
          'pointsExpiringNextMonth': 0.0,
          'totalEarnedPoints': customerStatusModel.totalEarnedPoints + points,
          'transactionsAmount': customerStatusModel.transactionsAmount + points,
          'transactionsAmountToNextLevel':
              customerStatusModel.transactionsAmountToNextLevel - points,
          'transactionsAmountWithoutDeliveryCosts':
              customerStatusModel.transactionsAmount + points,
          'transactionsCount': customerStatusModel.transactionsCount,
          'usedPoints': customerStatusModel.usedPoints
        }
      };

      setCustomerPointTransfer(points, phone, 'adding', id_receiver);
      return customer.doc(id_receiver).update(upate_point);
    }
  }

  //fetch customer campaign
  Future<ListCampaignModel?> fetchCustomerCampaign() async {
    List<CampaignModel> _newList = [];
    QuerySnapshot snapshot =
        await campaign.doc(user?.uid).collection("available").get();
    snapshot.docs.forEach((doc) {
      if (!_newList.contains(doc.data())) {
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
      "campaignId": '$i' + '23456789',
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
      "usersWhoUsedThisCampaignCount": i,
    };
    return campaign
        .doc(id)
        .collection("available")
        .add(available_data)
        .then((value) => print("Points Update"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> checkVoucher(String couponID) async {
    final list_id = <String>[];
    bool check = false;
    QuerySnapshot id = await campaign.doc(user?.uid).collection('bought').get();
    id.docs.forEach((doc) {
      list_id.add(doc['coupon']['id']);
    });
    for (int i = 0; i < list_id.length; i++) {
      if (couponID == list_id[i]) {
        check = true;
      }
    }
    return check;
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
      "campaignId": id,
      "purchaseAt": '2022-05-13T12:00:00.000Z',
      "costInPoints": double.tryParse(costInPoints),
      "used": false,
      "coupon": {
        "id": couponId,
        "code": 'ABCDEF',
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
    QuerySnapshot snapshot =
        await campaign.doc(user?.uid).collection("bought").get();
    snapshot.docs.forEach((doc) {
      if (!_newList.contains(doc.data())) {
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
      for (int i = 0; i < length; i++) {
        MaintenanceModel_1 trans1 = new MaintenanceModel_1();
        trans1.maintenanceId = "$i";
        trans1.productSku = data['maintenance $i']['productSku'];
        trans1.bookingDate =
            DateTime.parse(data['maintenance $i']['bookingDate']).toLocal();
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
      for (int i = 0; i < length; i++) {
        WarrantyModel trans = new WarrantyModel();
        trans.maintenanceId = "$i";
        trans.productSku = data['warranty $i']['productSku'];
        trans.bookingDate =
            DateTime.parse(data['warranty $i']['bookingDate']).toLocal();
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
    final select = await warranty.doc(user?.uid).get();
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
      warranty
          .doc(user?.uid)
          .update(warranty_data)
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
      maintenance
          .doc(user?.uid)
          .update(maintenance_data)
          .then((value) => print("Maintenance Update"))
          .catchError((error) => print("Failed to add user: $error"));
      return 'succes';
    }
  }

  //Request Support
  Future<void> requestSupport(RequestSupportModel requestSupportModel) async {
    var _value;
    final data = {
      'senderId': user?.uid,
      'senderName': requestSupportModel.senderName,
      'problemType': requestSupportModel.problemType,
      'description': requestSupportModel.description,
      'isActive': requestSupportModel.isActive ? "true" : "false",
      'photo': requestSupportModel.photo,
      'timestamp': DateTime.now().toIso8601String()
    };
    FirebaseFirestore.instance
        .collection('Request Support')
        .add(data)
        .then((value) => {_value = 1, print("Request Support add")})
        .catchError((error) =>
            {_value = 0, print("Failed to add Request Support: $error")});
    print(_value);
  }

  //Location
  Future<void> setStores() async {
    final data_store = {
      "offices 0": {
        "address":
            "109 Đường Nguyễn Duy Trinh, Phường Bình Trưng Tây, Quận 2, Thành phố Hồ Chí Minh",
        "id": "00",
        "lat": 10.7883213,
        "lng": 106.7582736,
        "name": "Cửa hàng số 0"
      },
      "offices 1": {
        "address":
            "447 Đường Phan Văn Trị, Phường 5, Quận Gò Vấp, Thành phố Hồ Chí Minh",
        "id": "01",
        "lat": 10.8222785,
        "lng": 106.6929956,
        "name": "Cửa hàng số 1"
      },
      "offices 2": {
        "address":
            "119/7/1 Đường số 7, Phường 3, Quận Gò Vấp, Thành phố Hồ Chí Minh",
        "id": "02",
        "lat": 10.8113253,
        "lng": 106.6817612,
        "name": "Cửa hàng số 2"
      }
    };
    return FirebaseFirestore.instance
        .collection('Location')
        .doc('store')
        .set(data_store)
        .then((value) => print("Store Added"))
        .catchError((error) => print("Failed to add store: $error"));
  }
}
