import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:linguabot/models/chat_model.dart';
import 'package:linguabot/utils/api_const.dart';

class ApiService {
  static Future<List<ChatModel>> sendMessage(
      {required String userId, required String newMessage}) async {

    final response = await http.post(
      Uri.parse("http://192.168.20.246:5000/message/conversation"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'newMessage': newMessage,
      }),
    );
    List<ChatModel> chatList = [];
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      chatList.add(ChatModel(
            msg: responseBody['botMsg']['message'],
            isUser: responseBody['botMsg']['user'],
            msgType: responseBody['botMsg']['msgType']));
      
      print(responseBody['botMsg']);
      print(newMessage);
      return chatList;
    } else {
      throw Exception('Failed to send message');
    }
  }

  // static Future<void> sendMessage({required String newMessage ,required String userId  })async{
  //   try {
  //     print("request send");
  //     var response = await http.post(
  //       Uri.parse("$kBaseUrl/message/conversation"),
  //       body: jsonEncode(
  //         {
  //           'newMessage': newMessage,
  //           'userId':userId
  //         }
  //       )
  //     );
  //     Map jsonResponse = jsonDecode(response.body);
  //     print(jsonResponse);
  //   } catch (e) {
  //     print("api error $e" );
  //     rethrow;
  //   }
  // }
}
