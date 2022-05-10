import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/Firebase/user_data.dart';
import 'package:open_loyalty/constant.dart';

class DetailInfo extends StatefulWidget {
  @override
  _DetailInfoState createState() => _DetailInfoState();
}
class _DetailInfoState extends State<DetailInfo> {
  late Future<UserData?> _value;
  late UserData userData = new UserData(id: '', name: '', phone: '', email: '', birthday: '', sex: '', location: '', cmd: '', nationality: '', loyaltyCardNumber: '');
  @override
  initState() {
    super.initState();
    _value = userData.getUser();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: FutureBuilder<UserData?>(
          future: _value,
          builder: (
              BuildContext context,
              AsyncSnapshot<UserData?> snapshot,
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
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.user,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.name}',
                          style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.venusMars,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.sex}',
                          style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.birthdayCake,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.birthday}', style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.flag,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.nationality}'.toUpperCase(),
                          style: const TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.idCard,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.cmd}', style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.phone,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.phone}', style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      dense: true,
                      leading: FaIcon(
                        FontAwesomeIcons.envelope,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.email}',
                          style: TextStyle(fontSize: mFontListTile)),
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.mapMarkerAlt,
                        size: mFontListTile,
                      ),
                      title: Text('${snapshot.data!.location}', style: TextStyle(fontSize: mFontListTile)),
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
