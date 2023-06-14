import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linguabot/components/chat_widget.dart';
import 'package:linguabot/utils/constants.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final bool _isTyping = false;

  TextEditingController? textEditingController;

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
    super.initState();
  }

  @override
  void dispose() {
    textEditingController!.dispose();
    super.dispose();
  }

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
                      child: Text(tag,style: TextStyle(color: Colors.black),),
                    ),
                  );
                }).toList(),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return  ChatWidget(
                    message: chatMessages[index]['msg'].toString(),
                    isUser: chatMessages[index]['isUser'] as bool,
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
              color:const Color(0xFFF8F7F7),
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
                        controller: textEditingController,
                        onSubmitted: (value) {
                          //TODO send message
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'How can I help you',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        //TODO send message
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
}

