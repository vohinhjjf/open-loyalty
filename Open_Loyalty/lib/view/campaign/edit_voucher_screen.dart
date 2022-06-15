import 'package:flutter/material.dart';
import 'package:open_loyalty/view/campaign/components/voucher.dart';

class EditVoucherScreen extends StatefulWidget {
  @override
  _EditVoucherScreenState createState() => _EditVoucherScreenState();
}

class _EditVoucherScreenState extends State<EditVoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[50], body: Voucher());
  }
}