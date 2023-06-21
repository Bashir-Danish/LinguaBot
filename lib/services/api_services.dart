import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/services/networking.dart';

class ApiService {
  static Future<List<Message>> sendMessage(
      {required String userId,
      required dynamic chatStory,
      required String newMsg}) async {
    // await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("https://linguabot.mortezaom.dev/message/conversation");
    final responseBody = await networkHelper.postData({
      'userId': userId,
      'newMessage': newMsg,
      'chatStory': chatStory,
    }, token: user.token);

    List<Message> chatList = [];
    chatList.add(Message(
      userId: user.userId,
      message: responseBody['botMsg']['message'],
      isUser: responseBody['botMsg']['user'],
    ));
    return chatList;
  }

  static Future<dynamic> translateText(String text) async {
    Box userBox;
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }
    UserModel user = userBox.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("https://linguabot.mortezaom.dev/message/translate");
    final responseBody =
        await networkHelper.postData({'text': text}, token: user.token);

    return responseBody['translatedText'];
  }

  static Future<dynamic> resetChat() async {
    Box userBox;
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }
    UserModel user = userBox.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/reset");
    final responseBody = await networkHelper
        .postData({'userId': user.userId}, token: user.token);

    return responseBody;
  }

  static Future<dynamic> signup(
    String username,
    String email,
    String password,
  ) async {
    Box userBox;
    NetworkHelper networkHelper =
        NetworkHelper("https://linguabot.mortezaom.dev/users/register");
    final responseBody = await networkHelper.postData({
      'username': username,
      'email': email,
      'password': password,
    });

    if (responseBody['error'] == null) {
      UserModel user = UserModel(
          userId: responseBody['userId'],
          username: responseBody['username'],
          email: responseBody['email'],
          token: responseBody['token']);
      if (Hive.isBoxOpen('users')) {
        userBox = Hive.box<UserModel>('users');
      } else {
        userBox = await Hive.openBox<UserModel>('users');
      }
      await userBox.clear();
      await userBox.put('user', user);
    }
    await Hive.openBox<Message>('messages');
    final Box<Message> messagesBox = Hive.box<Message>('messages');
    await messagesBox.clear();
    return responseBody;
  }

  static Future<dynamic> login(String email, String password) async {
    Box userBox;
    Box<Message> messagesBox;
    if (Hive.isBoxOpen('messages')) {
      messagesBox = Hive.box<Message>('messages');
    } else {
      messagesBox = await Hive.openBox<Message>('messages');
    }
    NetworkHelper networkHelper =
        NetworkHelper("https://linguabot.mortezaom.dev/users/login");
    final responseBody = await networkHelper.postData({
      'email': email,
      'password': password,
    });
      if (responseBody['error'] == null) {
      UserModel user = UserModel(
          userId: responseBody['userId'],
          username: responseBody['username'],
          email: responseBody['email'],
          token: responseBody['token']);
      if (Hive.isBoxOpen('users')) {
        userBox = Hive.box<UserModel>('users');
      } else {
        userBox = await Hive.openBox<UserModel>('users');
      }
      await userBox.clear();
      await userBox.put('user', user);
    }
    List<Message> messages = [];
    List<dynamic> resMessages = responseBody['messages'];
    for (var resMessage in resMessages) {
      Message message = Message(
        userId: resMessage['userId'],
        message: resMessage['message'],
        isUser: resMessage['user'],
      );
      messages.add(message);
    }

    await messagesBox.clear();
    await messagesBox.addAll(messages);

    return responseBody;
  }
}
