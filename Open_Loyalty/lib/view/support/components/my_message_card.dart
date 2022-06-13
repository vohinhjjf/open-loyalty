import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMessageCard extends StatefulWidget {
  final ChatMessageSocketModel message;
  const MyMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  _MyMessageCardState createState() => _MyMessageCardState();
}

class _MyMessageCardState extends State<MyMessageCard> {
  late String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String photo = widget.message.messId;
    return widget.message.type == "text"
        ? Container(
            width: 300,
            margin: EdgeInsets.fromLTRB(100, 0, 0, 12),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: mPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(children: <Widget>[
              Expanded(
                  child: Text(
                widget.message.text,
                style: TextStyle(color: Colors.white, fontSize: footnote),
              ))
            ]),
          )
        : Container(
            margin: EdgeInsets.fromLTRB(180, 0, 0, 12),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.network(
                "$baseUrl/chat/message/photo/$photo",
                headers: {
                  "authorization": "Bearer $token",
                  // Other headers if wanted
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
