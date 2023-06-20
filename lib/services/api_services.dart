import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/services/networking.dart';

class ApiService {
  static Future<List<Message>> sendMessage(
      {required String userId, required dynamic chatStory ,required String newMsg}) async {
    // await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/conversation");
    final responseBody = await networkHelper.postData({
      'userId': userId,
      'newMessage':newMsg,
      'chatStory': chatStory,
    },token: user.token);
  
    List<Message> chatList = [];
    chatList.add(Message(
      userId: user.userId,
      message: responseBody['botMsg']['message'],
      isUser: responseBody['botMsg']['user'],
    ));
    return chatList;
  }

  static Future<dynamic> translateText(String text) async {
    // await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/translate");
    final responseBody = await networkHelper.postData({'text': text},token: user.token);

    return responseBody['translatedText'];
  }
  static Future<dynamic>  resetChat() async {
    // await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    NetworkHelper networkHelper =
        NetworkHelper("http://192.168.20.246:5000/message/reset");
    final responseBody = await networkHelper.postData({'userId': user.userId},token: user.token);

    return responseBody;
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
      await Hive.openBox<UserModel>('users');
      Box box = Hive.box<UserModel>('users');
      await box.clear(); 
      await box.put('user', user);
    }
    await Hive.openBox<Message>('messages');
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
      // await Hive.openBox<UserModel>('users');
      Box box = Hive.box<UserModel>('users');
      await box.clear(); 
      await box.put('user', user);
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

    // await Hive.openBox<Message>('messages');
    Box<Message> messageBox = Hive.box<Message>('messages');
    await messageBox.clear();
    await messageBox.addAll(messages);
  
    return responseBody;
  }
}