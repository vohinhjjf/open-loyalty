import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/constant.dart';

class DetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: <Widget>[
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.user,
            size: footnote,
          ),
          title: Text('Nguyễn Minh Thái'.toUpperCase(),
              style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.venusMars,
            size: footnote,
          ),
          title: Text('Nam', style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.birthdayCake,
            size: footnote,
          ),
          title: Text('16/05/2001', style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.flag,
            size: footnote,
          ),
          title: Text('viet nam'.toUpperCase(),
              style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.idCard,
            size: footnote,
          ),
          title: Text('123456789', style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.phone,
            size: footnote,
          ),
          title: Text('1900068887', style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          dense: true,
          leading: FaIcon(
            FontAwesomeIcons.envelope,
            size: footnote,
          ),
          title: Text('nminhthai77@gmail.com', style: TextStyle(fontSize: footnote)),
        ),
        ListTile(
          leading: FaIcon(
            FontAwesomeIcons.mapMarkerAlt,
            size: footnote,
          ),
          title: Text('KTX khu A, ĐHQG', style: TextStyle(fontSize: footnote)),
        ),
      ],
    );
  }
}
