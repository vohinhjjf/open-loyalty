class CustomerModel {
  String customerId;
  bool active;
  String firstName;
  String lastName;
  String gender;
  String email;
  String phone;
  String birthDate;
  String levelId;
  String loyaltyCardNumber;
  bool agreement1;
  bool agreement2;
  bool agreement3;

  CustomerModel(
      {required this.customerId,
      required this.active,
      required this.firstName,
      required this.lastName,
        required this.birthDate,
        required this.email,
        required this.gender,
        required this.levelId,
        required this.phone,
        required this.loyaltyCardNumber,
        required this.agreement1,
        required this.agreement2,
        required this.agreement3});

  factory CustomerModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerModel(
      customerId: parsedJson["customerId"],
      active: parsedJson["active"],
      firstName: parsedJson["firstName"],
      lastName: parsedJson["lastName"],
      gender: parsedJson["gender"],
      email: parsedJson["email"],
      phone: parsedJson["phone"],
      birthDate: parsedJson["birthDate"],
      levelId: parsedJson["levelId"],
      loyaltyCardNumber: parsedJson["loyaltyCardNumber"],
      agreement1: parsedJson["agreement1"],
      agreement2: parsedJson["agreement2"],
      agreement3: parsedJson["agreement3"],
    );
  }
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
