import 'package:flutter/foundation.dart';

class ChatMessageModel {
  late String conversationId;
  late String senderId;
  late String senderName;
  late String message;
  late String messageTimestamp;

  ChatMessageModel(
      {
        required this.conversationId,
        required this.message,
        required this.messageTimestamp,
        required this.senderId,
        required this.senderName
      });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    message = json['message'];
    messageTimestamp = json['messageTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversationId'] = this.conversationId;
    data['senderId'] = this.senderId;
    data['senderName'] = this.senderName;
    data['message'] = this.message;
    data['messageTimestamp'] = this.messageTimestamp;

    return data;
  }
}

class ChatMessageSocketModel {
  late String userId;
  late String customerId;
  late String messId;
  late String type;
  late String from;
  late String text;
  //String filePath;

  ChatMessageSocketModel(
      {
        required this.customerId,
        required this.userId,
        required this.messId,
        required this.type,
        required this.from});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['customerId'] = this.customerId;
    data['messId'] = this.messId;
    data['type'] = this.type;

    return data;
  }

  ChatMessageSocketModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    customerId = json['customerId'];
    messId = json['messId'];
    type = json['type'];
    from = json['from'];
  }
}

class MessId {
  late String messId;
  MessId({required this.messId});

  MessId.fromJson(Map<String, dynamic> json) {
    messId = json['messageId'];
  }
}
