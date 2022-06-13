import 'package:flutter/material.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:open_loyalty/view/support/supporting_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartConverstionScreen extends StatefulWidget {
  @override
  _StartConverstionScreenState createState() => _StartConverstionScreenState();
}

class _StartConverstionScreenState extends State<StartConverstionScreen> {
  late List<ChatMessageModel> _listChatMess;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<ConversationProvider>(context).getMessages();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: subhead,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Hỗ trợ trực tuyến',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white,
              textColor: mPrimaryColor,
              onPressed: ()
              async {
                /*final prefs = await SharedPreferences.getInstance();
                String? customerId = prefs.getString('customerId');
                String? name = prefs.getString('name');
                _listChatMess = await getMessages();
                if (_listChatMess.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SupportingScreen(
                            customerId!, _listChatMess, name!);
                      },
                    ),
                  );
                } else {
                  //logic loi: neu k get dc list tn -> tao cuoc tro chuyen moi-> truyen tham so khac???
                  var value = await startConversationBloc.startConversation();
                  _listChatMess =
                      await Provider.of<ConversationProvider>(context)
                          .getMessages();
                  if (value.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SupportingScreen(
                              customerId!, _listChatMess, name!);
                        },
                      ),
                    );
                  }
                }*/
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Bắt đầu cuộc trò chuyện với nhân viên hỗ trợ",
                  style:
                      TextStyle(fontSize: subhead, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ));
  }
}
