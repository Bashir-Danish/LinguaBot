import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:linguabot/models/chat_model.dart';
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/utils/api_const.dart';

class ApiService {

  static Future<List<Message>> sendMessage(
      {required String userId, required List chatStory }) async {

    final response = await http.post(
      Uri.parse("http://192.168.20.246:5000/message/conversation"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'chatStory': chatStory,
      }),
    );
    List<Message> chatList = [];
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      chatList.add(Message(
        userId: 'fsfuadfa8s7dfa98df6a7daf',
        message:responseBody['botMsg']['message'] ,
        msgType: responseBody['botMsg']['msgType'],
        isUser:responseBody['botMsg']['user'] ));
  
      return chatList;
    } else {
      throw Exception('Failed to send message');
    }
  }
}
