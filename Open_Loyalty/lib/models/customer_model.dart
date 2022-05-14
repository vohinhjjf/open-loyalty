class CustomerModel {
  String id;
  String name;
  String gender;
  String birthday;
  String nationality;
  String cmd;
  String phone;
  String email;
  String loyaltyCardNumber;
  String levelId;
  String location;

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

}

class CustomerStatusModel {
  double points;
  double p2pPoints;
  double totalEarnedPoints;
  double usedPoints;
  double expiredPoints;
  double lockedPoints;
  String level;
  String levelName;
  double levelConditionValue;
  String nextLevel;
  String nextLevelName;
  double nextLevelConditionValue;
  double transactionsAmountWithoutDeliveryCosts;
  double transactionsAmountToNextLevel;
  double averageTransactionsAmount;
  int transactionsCount;
  double transactionsAmount;
  String currency;
  double pointsExpiringNextMonth;

  CustomerStatusModel(
      {required this.averageTransactionsAmount,
        required this.currency,
        required this.expiredPoints,
        required this.level,
        required this.levelConditionValue,
        required this.levelName,
        required this.lockedPoints,
        required this.nextLevel,
        required this.nextLevelConditionValue,
        required this.nextLevelName,
        required this.p2pPoints,
        required this.points,
        required this.pointsExpiringNextMonth,
        required this.totalEarnedPoints,
        required this.transactionsAmount,
        required this.transactionsAmountToNextLevel,
        required this.transactionsAmountWithoutDeliveryCosts,
        required this.transactionsCount,
        required this.usedPoints});

  factory CustomerStatusModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerStatusModel(
      averageTransactionsAmount:
          double.parse(parsedJson["averageTransactionsAmount"]),
      currency: parsedJson["currency"],
      expiredPoints: double.parse(parsedJson["expiredPoints"].toString()),
      level: parsedJson["level"],
      levelConditionValue:
          double.parse(parsedJson["levelConditionValue"].toString()),
      levelName: parsedJson["levelName"],
      lockedPoints: double.parse(parsedJson["lockedPoints"].toString()),
      nextLevel: parsedJson["nextLevel"],
      nextLevelConditionValue:
          double.parse(parsedJson["nextLevelConditionValue"].toString()),
      nextLevelName: parsedJson["nextLevelName"],
      p2pPoints: double.parse(parsedJson["p2pPoints"].toString()),
      points: double.parse(parsedJson["points"].toString()),
      pointsExpiringNextMonth:
          double.parse(parsedJson["pointsExpiringNextMonth"].toString()),
      totalEarnedPoints:
          double.parse(parsedJson["totalEarnedPoints"].toString()),
      transactionsAmount:
          double.parse(parsedJson["transactionsAmount"].toString()),
      transactionsAmountToNextLevel:
          double.parse(parsedJson["transactionsAmountToNextLevel"].toString()),
      transactionsAmountWithoutDeliveryCosts: double.parse(
          parsedJson["transactionsAmountWithoutDeliveryCosts"].toString()),
      transactionsCount: parsedJson["transactionsCount"],
      usedPoints: double.parse(parsedJson["usedPoints"].toString()),
    );
  }
}


