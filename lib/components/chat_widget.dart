import 'package:flutter/material.dart';
import 'package:linguabot/components/text_widget.dart';

import '../utils/constants.dart';

class ChatWidget extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatWidget({Key? key, required this.message, this.isUser = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            decoration: BoxDecoration(
              color: isUser ? kPrimaryColor :const Color(0xFFF8F7F7),
              borderRadius: BorderRadius.only(
                topLeft:const Radius.circular(15),
                topRight:const Radius.circular(15),
                bottomLeft: isUser ? const Radius.circular(15) :const Radius.circular(0),
                bottomRight: isUser ? const Radius.circular(0) :const  Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset:const Offset(0, 2),
                ),
              ],
            ),
            padding:const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (!isUser)
                //   Image.asset(
                //     'assets/images/chat_logo.png',
                //     width: 25,
                //     height: 25,
                //   ),
                TextWidget(label: message ,color: isUser ? Colors.white : Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}