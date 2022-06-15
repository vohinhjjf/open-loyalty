import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/Firebase/respository.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/customer_model.dart';

class DetailInfo extends StatefulWidget {
  @override
  _DetailInfoState createState() => _DetailInfoState();
}
class _DetailInfoState extends State<DetailInfo> {
  late Future<CustomerModel?> _value;
  final _repository = Repository();
  
  @override
  initState() {
    super.initState();
    _value = _repository.getCustomerData();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: FutureBuilder<CustomerModel?>(
          future: _value,
          builder: (
              BuildContext context,
              AsyncSnapshot<CustomerModel?> snapshot,
              ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Visibility(
                    visible: snapshot.hasData,
                    child: Text(
                      'snapshot.data',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.user,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.name}',
                          style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.venusMars,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.gender}',
                          style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.birthdayCake,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.birthday}', style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.flag,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.nationality}'.toUpperCase(),
                          style: const TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.idCard,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.cmd}', style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.phone,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.phone}', style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.envelope,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.email}',
                          style: TextStyle(fontSize: mFontSize)),
                    ),
                    Divider(height: 10,color: Colors.blue[100],indent: 20,endIndent: 20),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30),
                      leading: FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: mPrimaryColor,
                        size: mFontSize,
                      ),
                      title: Text('${snapshot.data!.location}', style: TextStyle(fontSize: mFontSize)),
                    ),
                  ],
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
