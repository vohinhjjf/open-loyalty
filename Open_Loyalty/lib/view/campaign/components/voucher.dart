import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/components/coupon_card.dart';
import 'package:open_loyalty/components/gradient_card.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/campaign_model.dart';
import 'package:open_loyalty/models/coupons_model.dart';
import 'package:open_loyalty/view/campaign/components/campaign_bloc.dart';
import 'package:open_loyalty/view/campaign/components/coupon_bloc.dart';


class Voucher extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Voucher> with SingleTickerProviderStateMixin {
  CampaignBloc campaignBloc = CampaignBloc();
  CouponBloc couponBloc = CouponBloc();

  final _formKey = GlobalKey<FormState>();
  var costInPoints = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Khuyến mãi 5%';
  String dropdowncontent = 'Chào mừng bạn mới';
  String? GetValue(){
    return this.dropdownvalue = dropdownvalue;
  }

  SetValue(String value){
    this.dropdownvalue = value;
  }

  String? GetContent(){
    return this.dropdowncontent = dropdowncontent;
  }

  SetContent(String content){
    this.dropdowncontent = content;
  }

  @override
  void initState() {
    super.initState();
    campaignBloc.fetchCustomerCampaign();
    couponBloc.fetchCustomerCoupon();
  }


  @override
  void dispose() {
    campaignBloc.dispose();
    couponBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: subhead,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Voucher',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: subhead),
        ),
      ),
      body: StreamBuilder(
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
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: ClipOval(
          child: Container(
            padding: EdgeInsets.all(0),
            color: mPrimaryColor,
            child: IconButton(
              onPressed: () {
                _showAddDialog();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )),
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

  _showAddDialog() {

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Container(
            child: Column(
              children: [
                const Text(
                  "Voucher",
                  style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(5.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Icon(
                              Icons.percent_rounded,
                              color: mPrimaryColor,
                              size: body
                            ),
                            DropdownButton(
                                value: dropdownvalue.isNotEmpty? dropdownvalue : null,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Khuyến mãi 5%"),
                                    value: "Khuyến mãi 5%",
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Khuyến mãi 10%"),
                                      value: "Khuyến mãi 10%"
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Khuyến mãi 15%"),
                                      value: "Khuyến mãi 15%"
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Khuyến mãi 20%"),
                                    value: "Khuyến mãi 20%",
                                  )

                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                    SetValue(dropdownvalue);
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog();
                                },
                                hint:Text("Chọn loại khuyến mãi")
                            )
                          ],
                        ),
                        //sex
                        const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Icon(
                              Icons.confirmation_num_sharp,
                              color: mPrimaryColor,
                              size: body,
                            ),
                            DropdownButton(
                                value: dropdowncontent.isNotEmpty? dropdowncontent:null,
                                items: const [ //add items in the dropdown
                                  DropdownMenuItem(
                                    child: Text("Chào mừng bạn mới"),
                                    value: "Chào mừng bạn mới",
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Tri ân khách hàng thân thiết"),
                                      value: "Tri ân khách hàng thân thiết"
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Khuyến mãi hàng tháng"),
                                    value: "Khuyến mãi hàng tháng",
                                  )
                                ],
                                hint:Text("Chọn loại khuyến mãi"),
                              onChanged: (String? value) {
                                  setState(() {
                                    dropdowncontent = value!;
                                    SetContent(dropdowncontent);
                                  });
                                  Navigator.of(context).pop();
                                  _showAddDialog();
                              },
                            )
                          ],
                        ),
                        //birthday
                        const SizedBox(),
                        TextFormField(
                            controller: costInPoints,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.paid,
                                  color: mPrimaryColor,
                                  size: body,
                                ),
                                labelText: 'Nhập vào số điểm',
                                labelStyle: TextStyle(fontSize: mFontListTile)
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Vui lòng nhập số điểm';
                              }
                              return null;
                          },
                        ),
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      EasyLoading.show(status: 'Đang cập nhật dữ liệu...');
                      FirebaseFirestore.instance.collection('Campaign').doc("available")
                          .collection("available").get().then((value) =>
                          campaignBloc.addCustomerCampaign(GetValue()!, value.size.toString(), GetContent()!, int.parse(costInPoints.text)).then((value){
                            EasyLoading.showSuccess('Thêm thành công');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/home", (Route<dynamic> route) => false);
                          }));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: LinearGradient(colors: [
                          mHighColor,
                          Colors.lightBlue,
                          Colors.lightBlueAccent
                        ])
                    ),
                    child: const Center(
                      child: Text(
                        'Thêm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}