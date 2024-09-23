import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
/*class UserType{
  final bool isUser;
  final String text;
  final DateTime date;

  UserType({required this.isUser, required this.text, required this.date});
}*/

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Huy');
  final ChatUser _geminiChatbot = ChatUser(
    id: '2',
    firstName: 'Gemini',
    profileImage:
        'https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/google-gemini-icon.png',
  );
  //List<ChatMessage> _message = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultimate Chatbot'),
        backgroundColor: Colors.green[100],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        inputOptions: InputOptions(trailing: [
          IconButton(
            onPressed: _imagePicker,
            icon: const Icon(
              Icons.image,
            ),
          )
        ]),
        currentUser: _currentUser,
        onSend: _sendMessage,
        messages: messages);
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == _geminiChatbot) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: _geminiChatbot,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getChatResponse(ChatMessage m) async{
  //   setState(()  {
  //     // final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: "AIzaSyCvhvDB0lPAte_qB1Xz8D0NF4_nsXbR31Q");
  //     // final content = [Content.text(UserType(isUser: true, text: , date: DateTime.now()))];
  //     // final response = await model.generateContent(content);
  //     // print(response.text);
  //     _message.insert(0, m);
  //     }
  //   );
  // }
  void _imagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: _currentUser,
          createdAt: DateTime.now(),
          text: "Describe this picture?",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatMessage);
    }
  }
}
