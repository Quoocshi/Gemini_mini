import 'package:flutter/material.dart';
import 'package:gemini_mini/components/blurBox.dart';
import 'package:gemini_mini/components/ovalShape.dart';
import 'package:gemini_mini/screen/chatbot_screen/chatpage.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List message = const [
    Text(
      'Tell me the characteristics of puberty',
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      'Can you explain in more detail?',
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      'How to build a balance, healthy diet?',
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      'How to improve height?',
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
    Text(
      'How to treat acne?',
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Fredoka',
        fontWeight: FontWeight.w600,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: const ClipRRect(
            borderRadius: BorderRadius.zero,
            child: BlurBox(sigmax: 10, sigmay: 10)),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Chatpage(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        elevation: 0,
        centerTitle: true,
        title: const Text('History',
            style: TextStyle(
              height: 22,
              fontSize: 40,
              fontFamily: 'FredokaOne',
              //fontWeight: FontWeight.w900,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          //oval shapes
          const Positioned(
            top: 10,
            right: 190,
            child: OvalShape(
              height: 200.0,
              width: 300.0,
              color: Color(0xFFA1D4B1),
            ),
          ),
          const Positioned(
            left: 150,
            top: 10,
            child: OvalShape(
              height: 300.0,
              width: 390.0,
              color: Color(0xFFFACA78),
            ),
          ),
          const Positioned(
            right: -40,
            top: 320,
            child: OvalShape(
              height: 150,
              width: 130,
              color: Color(0xFFFACA78),
            ),
          ),
          const Positioned(
            right: -40,
            top: 420,
            child: OvalShape(
              height: 150,
              width: 130,
              color: Color(0xFFFACA78),
            ),
          ),
          const Positioned(
            right: -40,
            top: 520,
            child: OvalShape(
              height: 150,
              width: 130,
              color: Color(0xFFFACA78),
            ),
          ),
          const Positioned(
            right: -40,
            top: 620,
            child: OvalShape(
              height: 150,
              width: 130,
              color: Color(0xFFFACA78),
            ),
          ),
          const Positioned(
            right: -40,
            top: 800,
            child: OvalShape(
              height: 200,
              width: 300,
              color: Color(0xFFA1D4B1),
            ),
          ),
          const Positioned(
            top: 820,
            left: -30,
            child: OvalShape(
              height: 150,
              width: 200,
              color: Color(0xFFFACA78),
            ),
          ),
          //make blur
          const BlurBox(
            sigmax: 60,
            sigmay: 60,
          ),
          Positioned(
            top: 600,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/icons/paws.png'),
              )),
            ),
          ),
          Positioned(
            top: 700,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/icons/paws.png'),
              )),
            ),
          ),
          //main feature
          ListView.builder(
              itemCount: message.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 100),
                        child: message[index],
                      ),
                    ],
                  )),
        ],
      ),
    );
  }
}
