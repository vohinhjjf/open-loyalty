import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeratorCard extends StatefulWidget {
  final ChatMessageSocketModel message;
  const ModeratorCard({Key? key, required this.message}) : super(key: key);

  @override
  _ModeratorCardState createState() => _ModeratorCardState();
}

class _ModeratorCardState extends State<ModeratorCard> {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.grey[350],
              backgroundImage: AssetImage("assets/images/moderator.png")),
          SizedBox(
            width: 3,
          ),
          widget.message.type == "text"
              ? Container(
                  width: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: Text(
                      widget.message.text,
                      style: TextStyle(color: Colors.black, fontSize: footnote),
                    ))
                  ]),
                )
              : Container(
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
                )
        ],
      ),
    );
  }
}
