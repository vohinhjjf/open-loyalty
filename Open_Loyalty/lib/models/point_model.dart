class ListPointTransferModel {
  int total;
  List<PointTransferModel> pointTransferModels = [];

  ListPointTransferModel({required this.pointTransferModels, required this.total});
}

class PointTransferModel {
  late String pointsTransferId;
  late String accountId;
  late String customerId;
  late DateTime createdAt;
  late DateTime expiresAt;
  late double value;
  late String state;
  late String type;
  //String transactionId;
  late String comment;
  late String issuer;

  PointTransferModel(item){
    value =  item["value"] as double;
    pointsTransferId = item["pointsTransferId"];
    accountId = item["accountId"];
    comment = item["comment"];
    customerId = item["customerId"];
    createdAt = DateTime.parse(item["createdAt"]);
    issuer =item["issuer"];
    expiresAt = DateTime.parse(item["expiresAt"]);
    state = item["state"];
    type = item["type"];
  }
}
