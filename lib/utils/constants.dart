import 'package:flutter/material.dart';

const kScaffoldBackgroundColor = Color(0xFFFBFBFB);
const kPrimaryColor= Color(0xFF6C82F9);


final kMyTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  appBarTheme:kAppBarTheme,
);

const kAppBarTheme =AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

final kTagStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.grey,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: const BorderSide(color: Color(0xFF6C82F9)),
  ),
  elevation: 2,
);


final chatMessages = [
  {
    "msg":"hi",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },
  {
    "msg":"tell me about english",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },
  {
    "msg":"hi",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },
  {
    "msg":"tell me about english",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },
  {
    "msg":"hi",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },
  {
    "msg":"tell me about english",
    "isUser":true
  },
  {
    "msg":"how can i asset you how can i asset you how can i asset you",
    "isUser":false
  },

];