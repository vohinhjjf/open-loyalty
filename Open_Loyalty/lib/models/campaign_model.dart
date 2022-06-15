class ListCampaignModel {
  late int total;
  List<CampaignModel> campaignModels = [];

  ListCampaignModel({required this.campaignModels, required this.total});

  ListCampaignModel.fromJson(Map<String, dynamic> data) {
    total = data.length;
    List<CampaignModel> temp = [];
    for (int i = 0; i < total; i++) {
      CampaignModel campaign = CampaignModel(data["available"]["campaign $i"]);
      temp.add(campaign);
    }
    campaignModels = temp;
  }
}

class CampaignModel {
  late String name;
  late String campaignId;
  late String reward;
  late bool active;
  late int costInPoints;
  late bool singleCoupon;
  late bool unlimited;
  //String transactionId;
  late int limit;
  late int limitPerUser;
  // bool campaignActivity;
  // bool campaignVisibility;
  late int daysInactive;
  late int daysValid;
  late bool featured;
  late bool public;
  late int usageLeft;
  late int usageLeftForCustomer;
  late bool canBeBoughtByCustomer;
  late int visibleForCustomersCount;
  late int usersWhoUsedThisCampaignCount;

  CampaignModel(item) {
    name = item["name"];
    campaignId = item["campaignId"];
    reward = item["reward"];
    active = item["active"];
    costInPoints = item["costInPoints"];
    singleCoupon = item["singleCoupon"];
    unlimited = item["unlimited"];
    limit = item["limit"];
    limitPerUser = item["limitPerUser"];
    // campaignActivity = item["campaignActivity"];
    // campaignVisibility = item["campaignVisibility"];
    daysInactive = item["daysInactive"];
    daysValid = item["daysValid"];
    featured = item["featured"];
    public = item["public"];
    usageLeft = item["usageLeft"];
    usageLeftForCustomer = item["usageLeftForCustomer"];
    canBeBoughtByCustomer = item["canBeBoughtByCustomer"];
    visibleForCustomersCount = item["visibleForCustomersCount"];
    usersWhoUsedThisCampaignCount = item["usersWhoUsedThisCampaignCount"];
  }
}
