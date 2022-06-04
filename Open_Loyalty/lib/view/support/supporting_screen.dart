import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_loyalty/constant.dart';
import 'package:open_loyalty/models/chat/chat_message_model.dart';
import 'package:open_loyalty/view/support/components/moderator_card.dart';
import 'package:open_loyalty/view/support/components/my_message_card.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SupportingScreen extends StatefulWidget {
  final String customerId;
  final List<ChatMessageModel> chatMessages;
  final String customerName;

  SupportingScreen(this.customerId, this.chatMessages, this.customerName);

  @override
  _SupportingScreenState createState() => _SupportingScreenState();
}

class _SupportingScreenState extends State<SupportingScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController messageTextEditController = TextEditingController();

  late ChatMessageModel message;


  final WebSocketChannel channel = IOWebSocketChannel.connect(webSocket);
  List<ChatMessageSocketModel> messageList = [];

  late PickedFile imageFile;
  final ImagePicker picker = ImagePicker();
  late String content;

  //1-cam 2-gallery

  @override
  void initState() {
    super.initState();
    message = ChatMessageModel(message: '', senderName: '', senderId: '', messageTimestamp: '', conversationId: '');

    message.conversationId = widget.chatMessages[0].conversationId;
    message.senderId = widget.customerId;
    message.senderName = widget.customerName;

    channel.stream.listen((data) async {
      ChatMessageSocketModel mess =
          ChatMessageSocketModel.fromJson(json.decode(data));

      String m;
      /*if (mess.type == "text") {
        //m = await getMess(mess.messId);
      } else {
        m = "";
      }
      mess.text = m;*/

      setState(() {
        if (mess.from == "Me" || mess.customerId == widget.customerId) {
          messageList.add(mess);

          SchedulerBinding.instance?.addPostFrameCallback((_) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: subhead,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Hỗ trợ trực tuyến',
            style: TextStyle(
              fontSize: subhead,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: getMessageList(),
            )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: mPrimaryColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    style: TextStyle(fontSize: footnote),
                    controller: messageTextEditController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Hãy viết gì đó ..."),
                  )),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: mPrimaryColor,
                      ),
                      child: const FaIcon(FontAwesomeIcons.camera,
                          color: Colors.white, size: footnote),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  InkWell(
                    onTap: () {
                      _sendMessage("text");
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: mPrimaryColor,
                      ),
                      child: const FaIcon(FontAwesomeIcons.paperPlane,
                          color: Colors.white, size: footnote),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _sendMessage(String type) async {
    var userId = message.senderId;
    var cusId = "22200000-0000-474c-b092-b0dd880c07e2";
    String messId;

    message.message = messageTextEditController.text.trim();
    message.messageTimestamp = DateTime.now().toString();

    /*if (type == "media") {
      messId = await Provider.of<ConversationProvider>(
        context,
      ).storeMessage(message, imageFile.path);
    } else {
      messId = await Provider.of<ConversationProvider>(
        context,
      ).storeMessageText(message);
    }

    if (messId != null) {
      ChatMessageSocketModel mess = new ChatMessageSocketModel();
      mess.userId = userId;
      mess.customerId = cusId;
      mess.messId = messId;
      mess.type = type;

      var jsonString = json.encode(mess.toJson());

      channel.sink.add(jsonString);
    }

    messageTextEditController.clear();

    Provider.of<ConversationProvider>(context).updateConversation(message);*/
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  ListView getMessageList() {
    List<Widget> listWidget = [];

    for (ChatMessageSocketModel message in messageList) {
      if (message.from == "Me") {
        listWidget.add(MyMessageCard(message: message));
      } else {
        listWidget.add(ModeratorCard(
          message: message,
        ));
      }
    }

    return ListView(
      children: listWidget,
      controller: _scrollController,
    );
  }

  void _openGallary(ImageSource source) async {
    final media = await picker.getImage(source: source);
    if (media != null) {
      this.setState(() {
        imageFile = media;
      });

      _sendMessage("media");
    }

    Navigator.of(context).pop();
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Chọn ảnh hoặc video"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.camera),
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera")),
              FlatButton.icon(
                  onPressed: () => _openGallary(ImageSource.gallery),
                  icon: const Icon(Icons.collections),
                  label: const Text("Thư viện"))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageTextEditController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
