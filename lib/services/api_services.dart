import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/services/networking.dart';

class ApiService {
  static Future<List<Message>> sendMessage(
      {required String userId, required dynamic chatStory}) async {
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/conversation");
    final responseBody = await networkHelper.postData({
      'userId': userId,
      'chatStory': chatStory,
    });

    List<Message> chatList = [];
    chatList.add(Message(
      userId: 'fsfuadfa8s7dfa98df6a7daf',
      message: responseBody['botMsg']['message'],
      msgType: responseBody['botMsg']['msgType'],
      isUser: responseBody['botMsg']['user'],
    ));
    return chatList;
  }

  static Future<dynamic> translateText(String text) async {
    NetworkHelper networkHelper = NetworkHelper("http://192.168.20.246:5000/message/translate");
    final responseBody = await networkHelper.postData({'text': text});

    return responseBody['translatedText'];
  }
}
