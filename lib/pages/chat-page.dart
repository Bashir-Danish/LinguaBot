import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linguabot/components/chat_widget.dart';
import 'package:linguabot/models/chat_model.dart';
import 'package:linguabot/services/api_services.dart';
import 'package:linguabot/utils/constants.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _scrollController;
  late FocusNode focusNode;
  List<String> tags = [
    'Grammar',
    'Part of Speech',
    'Tenses',
    'Tag5',
    'Tag7',
    'Tag8',
    'Tag9',
    'Tag10',
    'Tag11',
    'Tag12',
  ];

  @override
  void initState() {
    textEditingController = TextEditingController();
    _scrollController = ScrollController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];
  void onTagPressed(String tag) {
    print('Tag pressed: $tag');
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
                children: tags.map((tag) {
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
                    message: chatList[index].msg.toString(),
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
                        controller: textEditingController,
                        onSubmitted: (value) {
                          //TODO send message
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

  void scrollListToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds:500 ), curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT() async {
    String messageText =
        textEditingController.text; // Store the value before clearing
    setState(() {
      _isTyping = true;
      chatList.add(ChatModel(msg: messageText, isUser: true, msgType: 'msg'));
      textEditingController.clear();
      focusNode.unfocus();
    });

    try {
      print(messageText);
      chatList.addAll(
        await ApiService.sendMessage(
            newMessage: messageText, userId: '6489e8df31bd4b3e10691e58'),
      );
      setState(() {});
    } catch (e) {
      log('error 2 $e');
    } finally {
      setState(() {
        scrollListToBottom();
        _isTyping = false;
      });
    }
  }
}
