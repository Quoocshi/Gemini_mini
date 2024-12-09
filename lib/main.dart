import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_mini/screen/chatbot_screen/chatpage.dart';
import 'package:gemini_mini/screen/chatbot_screen/consts.dart';
//import 'package:gemini_mini/api/api_key.dart';

void main() {
  Gemini.init(apiKey: apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chatpage(),
    );
  }
}
