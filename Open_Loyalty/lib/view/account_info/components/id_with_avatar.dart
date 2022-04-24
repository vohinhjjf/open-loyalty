import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_loyalty/constant.dart';

class IdWithAvatar extends StatelessWidget {
  const IdWithAvatar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      color: mSecondaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/info.svg",
                height: 100,
              ),
            ),
          ),
          Text(
            "152221515121212",
            style: TextStyle(fontSize: 20, color: mSecondPrimaryColor),
          )
        ],
      ),
    );
  }
}
