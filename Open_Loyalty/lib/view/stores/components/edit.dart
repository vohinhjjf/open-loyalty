import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;
import '../../../constant.dart';
import 'package:open_loyalty/Firebase/locations.dart' as locations;

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    locations.getStores();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
        title: Text(
          'Danh sách cửa hàng',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: subhead),
        ),
      ),
      body: FutureBuilder<locations.Locations>(
            future: locations.getStores(),
            builder: (context, AsyncSnapshot<locations.Locations> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.size == 0) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.2,
                        ),
                        Text("Hiện tại không có cửa hàng nào!",
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
    );
  }

  Widget buildList(AsyncSnapshot<locations.Locations> snapshot) {
    return Scaffold(
        body: ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          _UpdateStoreDialog(snapshot.data!.offices,index);
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                    colors: [Color(0xfffdfcfb), Color(0xffe2d1c3)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xffe2d1c3),
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: CustomPaint(
                                size: const Size(100, 150),
                                painter: CustomCardShapePainter(
                                    24, Colors.white, Color(0xB3FFFFFF)),
                              ),
                            ),
                            Positioned.fill(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset('assets/images/shop.png'),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${snapshot.data!.offices[index].name}',
                                          style: const TextStyle(
                                              fontSize: mFontListTile,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(),
                                        Text(
                                          '${snapshot.data!.offices[index].address}',
                                          style: const TextStyle(
                                            fontSize: footnote,
                                          ),
                                        ),
                                        const SizedBox(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: Image.asset('assets/images/compass.png',
                                              height: 20,
                                              width: 20),
                                              flex: 0,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${ChangeUnitLat(snapshot.data!.offices[index].lat)}, ${ChangeUnitLng(snapshot.data!.offices[index].lng)}',
                                                style: const TextStyle(
                                                  fontSize: footnote,
                                                ),
                                              ),
                                              flex: 1,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
          ),
        floatingActionButton: ClipOval(
          child: Container(
            padding: EdgeInsets.all(0),
            color: mPrimaryColor,
            child: IconButton(
              onPressed: () {
                _AddStoreDialog(snapshot.data!.offices);
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

  String ChangeUnitLat(double value){
    var d = value.toInt();
    var m = ((value - d)*60.0).toInt();
    var s = ((value - d - m/60.0) * 3600.0).toStringAsFixed(1);
    String dir;
    if(value>0){
      dir ="N";
    }
    else{
      dir = "S";
    }
    return "$d⁰$m'$s״$dir";
  }
  String ChangeUnitLng(double value){
    var d = value.toInt();
    var m = ((value - d)*60).toInt();
    var s = ((value - d - m/60.0) * 3600.0).toStringAsFixed(1);
    String dir;
    if(value>0){
      dir ="E";
    }
    else{
      dir = "W";
    }
    return "$d⁰$m'$s״$dir";
  }

  _UpdateStoreDialog(List<locations.Office> office, int index) {
    var name = TextEditingController();
    var location = TextEditingController();
    var longitude = TextEditingController();
    var latitude = TextEditingController();
    name.text = office[index].name;
    location.text = office[index].address;
    longitude.text = office[index].lat.toString();
    latitude.text = office[index].lng.toString();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          titlePadding: const EdgeInsets.fromLTRB(10.0, 24.0, 10.0, 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Container(
            width: 100,
            child: Column(
              children: [
                const Text(
                  "Cập nhật cửa hàng",
                  style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(2.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(20.0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                              icon: const Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: mPrimaryColor,
                                  size: body
                              ),
                              labelText: 'Tên của hàng',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập tên cửa hàng';
                            }
                            return null;
                          },
                        ),
                        //sex
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: location,
                          decoration: const InputDecoration(
                              icon: const Icon(
                                Icons.location_on_rounded,
                                color: mPrimaryColor,
                                size: body,
                              ),
                              labelText: 'Địa chỉ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập địa chỉ';
                            }
                            return null;
                          },
                        ),
                        //birthday
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: longitude,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.language,
                              color: mPrimaryColor,
                              size: body,
                            ),
                              labelText: 'Kinh độ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập kinh độ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: latitude,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.language,
                              color: mPrimaryColor,
                              size: body,
                            ),
                              labelText: 'Vĩ độ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập vĩ độ';
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
                    var data_update = {
                      "offices $index": {
                        "address": location.text,
                        "id": office[index].id,
                        "lat": double.parse(longitude.text),
                        "lng": double.parse(latitude.text),
                        "name": name.text
                      }
                    };
                      FirebaseFirestore.instance.collection('Location').doc("store")
                          .update(data_update).then((value) =>{
                            EasyLoading.showSuccess('Cập nhật thành công'),
                            Navigator.pop(context)
                          });
                    },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: const LinearGradient(colors: [
                          mHighColor,
                          Colors.lightBlue,
                          Colors.lightBlueAccent
                        ])
                    ),
                    child: const Center(
                      child: Text(
                        'Cập nhật',
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

  _AddStoreDialog(List<locations.Office> office) {
    var name = TextEditingController();
    var location = TextEditingController();
    var longitude = TextEditingController();
    var latitude = TextEditingController();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          title: Container(
            width: 100,
            child: Column(
              children: [
                const Text(
                  "Cập nhật cửa hàng",
                  style: TextStyle(fontSize: mFontSize, color: Colors.blue),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(2.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(20.0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                              icon: const Icon(
                                  Icons.drive_file_rename_outline_rounded,
                                  color: mPrimaryColor,
                                  size: body
                              ),
                              labelText: 'Tên của hàng',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập tên cửa hàng';
                            }
                            return null;
                          },
                        ),
                        //sex
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: location,
                          decoration: const InputDecoration(
                              icon: const Icon(
                                Icons.location_on_rounded,
                                color: mPrimaryColor,
                                size: body,
                              ),
                              labelText: 'Địa chỉ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập địa chỉ';
                            }
                            return null;
                          },
                        ),
                        //birthday
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: longitude,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.language,
                                color: mPrimaryColor,
                                size: body,
                              ),
                              labelText: 'Kinh độ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập kinh độ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          child: Padding(padding: const EdgeInsets.fromLTRB(0,0,0,20.0),),
                        ),
                        TextFormField(
                          controller: latitude,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.language,
                                color: mPrimaryColor,
                                size: body,
                              ),
                              labelText: 'Vĩ độ',
                              labelStyle: TextStyle(fontSize: mFontSize),
                              contentPadding: EdgeInsets.zero
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Vui lòng nhập vĩ độ';
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
                    var data_add = {
                      "offices ${office.length}": {
                        "address": "${location.text}",
                        "id": "${office.length}",
                        "lat": double.parse(longitude.text),
                        "lng": double.parse(latitude.text),
                        "name": name.text
                      }
                    };
                    FirebaseFirestore.instance.collection('Location').doc("store")
                        .update(data_add).then((value) =>{
                      EasyLoading.showSuccess('Thêm thành công'),
                      Navigator.pop(context)
                    }).catchError((error) => print("Failed to add store: $error"));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28) //
                        ),
                        gradient: const LinearGradient(colors: [
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
class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}