class ListCouponModel {
  late int total;
  List<CouponModel> couponModel = [];

  ListCouponModel({required this.couponModel, required this.total});
}

class CouponModel {
  late bool canBeUsed;
  late String campaignId;
  late DateTime purchaseAt;
  late double costInPoints;
  late bool used;
  late String couponId;
  late String couponCode;
  late String status;
  late DateTime activeSince;
  late DateTime activeTo;
  late String deliveryStatus;

  CouponModel(item) {
    canBeUsed = item["canBeUsed"];
    campaignId = item["campaignId"];
    purchaseAt = DateTime.parse(item["purchaseAt"]);
    costInPoints = item["costInPoints"].toDouble();
    used = item["used"];
    couponId = item["coupon"]["id"];
    couponCode = item["coupon"]["code"];
    status = item["status"];
    activeSince = DateTime.parse(item["activeSince"]);
    activeTo = DateTime.parse(item["activeTo"]);
    deliveryStatus = item["deliveryStatus"];
  }
}
