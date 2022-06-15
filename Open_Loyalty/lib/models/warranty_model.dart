class ListWarrantyModel {
  int? total;
  List<WarrantyModel> warrantyModels = [];

  ListWarrantyModel({required this.warrantyModels, this.total});

}

class WarrantyModel {
  late String warrantyId;
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