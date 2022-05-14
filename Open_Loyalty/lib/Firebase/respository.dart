import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/models/customer_model.dart';
import 'package:open_loyalty/models/maintenance.dart';
import 'package:open_loyalty/models/point_model.dart';
import 'package:open_loyalty/models/warranty_model.dart';

import 'firebase_realtime_data_service.dart';

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

  Future<void> setPointTransfer() =>
      customerApiProvider.setCustomerPointTransfer();

  Future<ListCampaignModel?> fetchCustomerCampaign() =>
      customerApiProvider.fetchCustomerCampaign();

  Future<void> setCustomerCampaign() =>
      customerApiProvider.setCustomerCampaign();

  dynamic buyCoupon(String couponId, String costInPoints) => customerApiProvider.buyCoupon(couponId,costInPoints);

  Future<ListCouponModel?> fetchCustomerCoupon() =>
      customerApiProvider.fetchCustomerCoupon();


  Future<ListMaintenanceModel_1> fetchCustomerMaintenanceBooking() =>
      customerApiProvider.fetchCustomerMaintenanceBooking();

  Future<ListWarrantyModel> fetchCustomerWarrantyBooking() =>
      customerApiProvider.fetchCustomerWarrantyBooking();

  Future<String?> bookingWarranty(
      String productSku,
      String warrantyCenter,
      DateTime bookingDate,
      String bookingTime,
      DateTime createAt,
      ) async {
    final res = await CustomerApiProvider().bookingWarranty(
        productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    return res;
  }

  Future<String?> booking(
      String productSku,
      String warrantyCenter,
      DateTime bookingDate,
      String bookingTime,
      DateTime createAt,
      ) async {
    final res = await CustomerApiProvider().booking(
        productSku, warrantyCenter, bookingDate, bookingTime, createAt);
    return res;
  }
}