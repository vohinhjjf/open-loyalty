import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/models/maintenance.dart';
import 'package:open_loyalty/models/point_model.dart';
import 'package:open_loyalty/models/warranty_model.dart';

import '../models/request_support_model.dart';
import 'firebase_realtime_data_service.dart';
import 'locations.dart';

class Repository {
  final customerApiProvider = CustomerApiProvider();

  Future<void> addCustomerData(
      CollectionReference users,
      String id,
      String name,
      String phone,
      String email,
      String loyaltyCardNumber) =>
      customerApiProvider.addUser(users, id, name, phone, email, loyaltyCardNumber);

  Future<CustomerModel?> getCustomerData() =>
      customerApiProvider.getUser();

  Future<CustomerStatusModel?> fetchCustomerStatus() =>
      customerApiProvider.fetchCustomerStatus();

  Future<ListPointTransferModel> fetchPointTransfer() =>
      customerApiProvider.fetchCustomerPointTransfer();

  Future<void> setPointTransfer(double value, String comment, String type, String id) =>
      customerApiProvider.setCustomerPointTransfer(value,comment,type,id);

  Future<String?> PointTransfer(String receiver, double points) =>
      customerApiProvider.pointTransfer(receiver, points);

  Future<ListCampaignModel?> fetchCustomerCampaign() =>
      customerApiProvider.fetchCustomerCampaign();

  Future<void> addCustomerCampaign(
      String name,
      String campaignId,
      String reward,
      int costInPoints) =>
      customerApiProvider.addCustomerCampaign(name,campaignId,reward,costInPoints);

  dynamic buyCoupon(String couponId, String costInPoints) =>
      customerApiProvider.buyCoupon(couponId,costInPoints);

  Future<bool> checkVoucher(String couponID) =>
      customerApiProvider.checkVoucher(couponID);

  Future<ListCouponModel?> fetchCustomerCoupon() =>
      customerApiProvider.fetchCustomerCoupon();

  Future<ListMaintenanceModel_1> fetchCustomerMaintenanceBooking() =>
      customerApiProvider.fetchCustomerMaintenanceBooking();

  Future<MaintenanceModel_1> CheckMaintenanceBooking(String id) =>
      customerApiProvider.CheckMaintenanceBooking(id);

  Future<ListWarrantyModel> fetchCustomerWarrantyBooking() =>
      customerApiProvider.fetchCustomerWarrantyBooking();

  Future<WarrantyModel> CheckWarrantyBooking(String id) =>
      customerApiProvider.CheckWarrantyBooking(id);

  Future<String?> bookingWarranty(
      String warrantyId,
      String productSku,
      String warrantyCenter,
      DateTime bookingDate,
      String bookingTime,
      DateTime createAt,
      ) async {
    final res = await CustomerApiProvider().bookingWarranty(
        warrantyId,productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    return res;
  }

  Future<String?> booking(
      String maintenanceId,
      String productSku,
      String warrantyCenter,
      DateTime bookingDate,
      String bookingTime,
      DateTime createAt,
      ) async {
    final res = await CustomerApiProvider().booking(
        maintenanceId, productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    return res;
  }

  Future<void> UpdatePointSender(String comment, double points) =>
      customerApiProvider.UpdatePointSender(comment, points);

  Future<void> UpdatePointReceiver(String comment, double points) =>
      customerApiProvider.UpdatePointReceiver(comment, points);

  Future<void> setStores() => customerApiProvider.setStores();

  Future<void> requestSupport(RequestSupportModel requestSupportModel) =>
      customerApiProvider.requestSupport(requestSupportModel);

}