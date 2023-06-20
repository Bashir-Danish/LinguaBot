import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linguabot/components/chat_widget.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/services/api_services.dart';
import 'package:linguabot/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:linguabot/models/message_model.dart';

class ChatPage extends StatefulWidget {
  final ValueNotifier<bool>? msgClearedNotifier;

  ChatPage({this.msgClearedNotifier});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // --------  variables ---------//
  bool _isTyping = false;
  List<Message> chatList = [];
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late FocusNode focusNode;

// --------  Lifecycle hooks ---------//
  @override
  void initState() {
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
    widget.msgClearedNotifier?.addListener(_handleMessagesCleared);
    _openMessageBox();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    focusNode.dispose();
    Hive.close();
    widget.msgClearedNotifier?.removeListener(_handleMessagesCleared);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print('Chat page clicked');
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: kTags.keys.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      onPressed: () => onTagPressed(tag),
                      style: kTagStyle,
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    message: chatList[index].message.toString(),
                    isUser: chatList[index].isUser,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.black,
                size: 18,
              ),
            ],
            Material(
              color: const Color(0xFFF8F7F7),
              elevation: 10,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: _textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT();
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'How can I help you',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        await sendMessageFCT();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// -----------------------------------  Functions ----------------------------------------//

  Future<void> _handleMessagesCleared() async {
    final Box<Message> messagesBox = Hive.box<Message>('messages');
    await messagesBox.clear();
    _openMessageBox();
  }

  Future<void> _openMessageBox() async {
    await Hive.openBox<Message>('messages');
    setState(() {
      chatList = Hive.box<Message>('messages').values.toList();
    });
  }

  Future<void> onTagPressed(String tag) async {
    await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');
    await Hive.openBox<Message>('messages');
    String messageText = kTags[tag]!;

    Message userMessage = Message(
      userId: user.userId,
      message: tag,
      isUser: true,
      msgType: 'msg',
    );
    setState(() {
      _isTyping = true;
      chatList.add(userMessage);
      Hive.box<Message>('messages').add(userMessage);
      _textEditingController.clear();
      focusNode.unfocus();
      scrollListToBottom();
    });
    try {
      List<Message> botMessages = await ApiService.sendMessage(
        userId: user.userId,
        newMsg: tag,
        chatStory: [
          {
            'role': 'user',
            'content': messageText,
          }
        ],
      );

      for (Message botMessage in botMessages) {
        Hive.box<Message>('messages').add(botMessage);
      }

      setState(() {
        chatList.addAll(botMessages);
      });
    } catch (e) {
      log('error 2 $e');
    } finally {
      setState(() {
        _isTyping = false;
        scrollListToBottom();
      });
    }
  }

  void scrollListToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  Future<void> sendMessageFCT() async {
    String messageText = _textEditingController.text;
    await Hive.openBox<UserModel>('users');
    Box box = Hive.box<UserModel>('users');
    UserModel user = box.get('user');

    Message userMessage = Message(
      userId: user.userId,
      message: messageText,
      isUser: true,
      msgType: 'msg',
    );
    setState(() {
      _isTyping = true;
      chatList.add(userMessage);
      Hive.box<Message>('messages').add(userMessage);
      _textEditingController.clear();
      focusNode.unfocus();
      scrollListToBottom();
    });
    List<Map<String, String>> previous = chatList.map((message) {
      return {
        'role': message.isUser ? 'user' : 'assistant',
        'content': message.message,
      };
    }).toList();
    try {
      List<Message> botMessages = await ApiService.sendMessage(
          userId: user.userId, newMsg: messageText, chatStory: previous);

      for (Message botMessage in botMessages) {
        Hive.box<Message>('messages').add(botMessage);
      }

      setState(() {
        chatList.addAll(botMessages);
      });
    } catch (e) {
      log('error 2 $e');
    } finally {
      setState(() {
        _isTyping = false;
        scrollListToBottom();
      });
    }
  }
}
