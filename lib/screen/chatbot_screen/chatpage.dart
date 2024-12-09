import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_mini/components/blurBox.dart';
import 'package:gemini_mini/components/ovalShape.dart';
import 'package:gemini_mini/screen/chatbot_screen/history.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
//import 'package:image_picker/image_picker.dart';

// class UserType {
//   final bool isUser;
//   final String text;
//   final DateTime date;

//   UserType({required this.isUser, required this.text, required this.date});
// }

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final String userid = '1';
  final gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'Huy');
  final ChatUser _geminiChatbot = ChatUser(
      id: '2',
      firstName: 'Buzz LightYear',
      profileImage:
          'https://scontent.xx.fbcdn.net/v/t1.15752-9/462537363_540085355338024_9186673996747382277_n.png?stp=cp0_dst-png&_nc_cat=100&ccb=1-7&_nc_sid=0024fc&_nc_eui2=AeEFibzgFswbFRQutFJg1XEOnizfq1KS3bGeLN-rUpLdsZuC2FtsLWXHhV2l9AHLIHi33kQUANXZxs2oicE6oza6&_nc_ohc=gJOrKfTf2GEQ7kNvgHjwFQS&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_gid=AUlXEaCuUAhpTD_73PT9MfV&oh=03_Q7cD1QFTIsbFdWCLVxyjLcG__GnZ52xODBD3xRvz4YenCJrgzQ&oe=672EB89F');
  //List<ChatMessage> _message = <ChatMessage>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            flexibleSpace: const ClipRRect(
                borderRadius: BorderRadius.zero,
                child: BlurBox(sigmax: 10, sigmay: 10)),
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(IconsaxPlusLinear.arrow_left_1)),
            elevation: 0,
            titleSpacing: -10,
            title: const Text('Chatbot',
                style: TextStyle(
                  height: 22,
                  fontSize: 40,
                  fontFamily: 'FredokaOne',
                  //fontWeight: FontWeight.w900,
                )),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const History(),
                      ),
                    );
                  },
                  icon: const Icon(size: 30, IconsaxPlusLinear.clock_1)),
            ]),
        body: Stack(
          children: [
            //oval shapes
            const Positioned(
              top: 30,
              right: 280,
              child: OvalShape(
                height: 200.0,
                width: 200.0,
                color: Color(0xFFA1D4B1),
              ),
            ),
            const Positioned(
              left: 200,
              top: 150,
              child: OvalShape(
                height: 200.0,
                width: 500.0,
                color: Color(0xFFFACA78),
              ),
            ),
            //make blur
            const BlurBox(
              sigmax: 60,
              sigmay: 60,
            ),
            //main feature
            _buildUI()
          ],
        ));
  }

  Widget _buildUI() {
    return DashChat(
      // inputOptions: InputOptions(trailing: [
      //   IconButton(
      //     onPressed: _imagePicker,
      //     icon: const Icon(
      //       Icons.image,
      //     ),
      //   )
      // ]),
      inputOptions: InputOptions(
        sendButtonBuilder: (VoidCallback onSend) => IconButton(
          iconSize: 30,
          icon: const Icon(
            IconsaxPlusLinear.send_1,
            color: Color.fromARGB(255, 110, 163, 127),
          ),
          onPressed: onSend,
        ),
        sendOnEnter: true,
        alwaysShowSend: true,
        inputTextStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'FredokaOne',
          color: Color(0x70000000),
        ),
        inputToolbarMargin:
            const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
        inputDecoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
          filled: true,
          hintText: 'Write your message',
          hintStyle: const TextStyle(
            fontSize: 16,
            fontFamily: 'FredokaOne',
            color: Color(0x70000000),
          ),
          fillColor: const Color(0xFFA1D4B1),
        ),
      ),
      messageOptions: MessageOptions(
          currentUserContainerColor: const Color(0xFFF85525),
          containerColor: const Color(0xFFFACA78),
          messageTextBuilder: (message, previousMessage, nextMessage) => Text(
                message.text,
                style: message.user.id == userid
                    ? const TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      )
                    : const TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
              ),
          messageDecorationBuilder: (message, previousMessage, nextMessage) =>
              BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: message.user.id == userid
                    ? const Color(0xFFF85525)
                    : const Color(0xFFFACA78),
              )),
      currentUser: _currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  //send message
  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      String prompt = 'From now you are BuzzLightYear. $question';
      // List<Uint8List>? images;
      // if (chatMessage.medias?.isNotEmpty ?? false) {
      //   images = [
      //     File(chatMessage.medias!.first.url).readAsBytesSync(),
      //   ];
      // }
      gemini.streamGenerateContent(prompt).listen((event) {
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
          //convert all the response from gemini into one string
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

  // void _imagePicker() async {
  //   ImagePicker picker = ImagePicker();
  //   XFile? file = await picker.pickImage(source: ImageSource.gallery);
  //   if (file != null) {
  //     ChatMessage chatMessage = ChatMessage(
  //         user: _currentUser,
  //         createdAt: DateTime.now(),
  //         text: "Describe this picture?",
  //         medias: [
  //           ChatMedia(url: file.path, fileName: "", type: MediaType.image)
  //         ]);
  //     _sendMessage(chatMessage);
  //   }
  // }
}
