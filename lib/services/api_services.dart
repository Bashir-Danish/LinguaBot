import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/services/networking.dart';

class ApiService {
  static Future<List<Message>> sendMessage(
      {required String userId, required dynamic chatStory ,required String newMsg}) async {
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/conversation");
    final responseBody = await networkHelper.postData({
      'userId': userId,
      'newMessage':newMsg,
      'chatStory': chatStory,
    });
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    List<Message> chatList = [];
    chatList.add(Message(
      userId: user.userId,
      message: responseBody['botMsg']['message'],
      msgType: responseBody['botMsg']['msgType'],
      isUser: responseBody['botMsg']['user'],
    ));
    return chatList;
  }

  static Future<dynamic> translateText(String text) async {
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/translate");
    final responseBody = await networkHelper.postData({'text': text});

    return responseBody['translatedText'];
  }

  static Future<dynamic> signup(
    String username,
    String email,
    String password,
  ) async {
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/users/register");
    final responseBody = await networkHelper.postData({
      'username': username,
      'email': email,
      'password': password,
    });
    
    if (responseBody['error'] == null) {
      UserModel user = UserModel(userId: responseBody['userId'], username: responseBody['username'], email: responseBody['email'], token: responseBody['token']);
      Box box = Hive.box<UserModel>('users');
      await box.clear(); 
      await box.put('user', user);
    }
    final Box<Message> messagesBox = Hive.box<Message>('messages');
    await messagesBox.clear();
    return responseBody;
  }

  static Future<dynamic> login(String email, String password) async {
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/users/login");
    final responseBody = await networkHelper.postData({
      'email': email,
      'password': password,
    });
     if (responseBody['error'] == null) {
      UserModel user = UserModel(userId: responseBody['userId'], username: responseBody['username'], email: responseBody['email'], token: responseBody['token']);
      Box box = Hive.box<UserModel>('users');
      await box.clear(); 
      await box.put('user', user);
    }

    return responseBody;
  }
}
