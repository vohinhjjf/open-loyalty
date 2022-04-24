class ListMaintenanceModel_1 {
  int? total;
  List<MaintenanceModel_1> maintenanceModels = [];
  ListMaintenanceModel_1({required this.maintenanceModels, this.total});

}

class MaintenanceModel_1 {
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
