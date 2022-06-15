import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/components/coupon_card.dart';
import 'package:open_loyalty/components/gradient_card.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/view/campaign/components/campaign_bloc.dart';
import 'package:open_loyalty/view/campaign/components/coupon_bloc.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  List<Widget> list = [
    const Tab(
      child: Text(
        "Mới nhất",
        style: TextStyle(color: Colors.black, fontSize: subhead),
      ),
    ),
    const Tab(
      child: Text(
        "Đã đổi",
        style: TextStyle(color: Colors.black, fontSize: subhead),
      ),
    ),
  ];
  CampaignBloc campaignBloc = CampaignBloc();
  CouponBloc couponBloc = CouponBloc();
  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: list.length, vsync: this, initialIndex: 0);
    campaignBloc.fetchCustomerCampaign();
    couponBloc.fetchCustomerCoupon();
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  // @override
  // void didChangeDependencies() {
  //   print("heleo");
  //   campaignBloc.fetchCustomerCampaign();
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    campaignBloc.dispose();
    couponBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: subhead,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: mPrimaryColor,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: mFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ), //For Selected tab
            unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.black),
            indicatorColor: mPrimaryColor,
            onTap: (index) {
              if (index == 0) {
                campaignBloc.fetchCustomerCampaign();
              }
              couponBloc
                  .fetchCustomerCoupon(); // Tab index when user select it, it start from zero
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text(
            'Tích điểm đổi quà',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: subhead),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            StreamBuilder(
              stream: campaignBloc.campaign,
              builder: (context, AsyncSnapshot<ListCampaignModel> snapshot) {
                print(
                    "connection state: " + snapshot.connectionState.toString());
                if (snapshot.hasData) {
                  if (snapshot.data?.total == 0) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          const Text("Hiện tại không có khuyến mãi nào!",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: mFontSize)),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SvgPicture.asset(
                            "assets/images/empty.svg",
                            height: size.height * 0.3,
                          ),
                        ],
                      ),
                    );
                  }
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            StreamBuilder(
              stream: couponBloc.customerCoupon,
              builder: (context, AsyncSnapshot<ListCouponModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.total == 0) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.2,
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 40.0),
                            child: Text(
                                "Hãy dùng điểm để đổi lấy các khuyến mãi giá trị nào!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: mFontSize)),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SvgPicture.asset(
                            "assets/images/empty.svg",
                            height: size.height * 0.3,
                          ),
                        ],
                      ),
                    );
                  }
                  return buildListCoupon(snapshot);
                } else if (snapshot.hasError) {
                  return Text("LOi" + snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ListCampaignModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.total,
      itemBuilder: (context, index) {
        return buildData(snapshot.data!.campaignModels[index]);
      },
    );
  }

  Widget buildData(CampaignModel campaignModel) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GradientCard(
          couponId: campaignModel.campaignId,
          name: campaignModel.name,
          campaignActivity: campaignModel.reward,
          costInPoints: campaignModel.costInPoints.toString(),
          startColor: Color(0xfffdfcfb),
          endColor: Color(0xffe2d1c3)
        ));
  }

  Widget buildListCoupon(AsyncSnapshot<ListCouponModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data?.total,
        itemBuilder: (context, index) {
          return buildDataCoupon(snapshot.data!.couponModel[index]);
        });
  }

  Widget buildDataCoupon(CouponModel couponModel) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CouponCard(
          activeSince: couponModel.activeSince.toString(),
          activeTo: couponModel.activeTo.toString(),
          couponCode: couponModel.couponCode,
          status: couponModel.status,
          startColor: Color(0xfffdfcfb),
          endColor: Color(0xffe2d1c3)
        ));
  }
}
