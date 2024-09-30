import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';

class ChatContainer extends StatelessWidget {
  ChatContainer(
      {required this.mensagem,
      required this.ismotorist,
      required this.name,
      required this.type,
      required this.time,
      super.key});
  String name;
  String mensagem;
  bool ismotorist;
  BubbleType type;
  String time;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(time);
    String format = DateFormat("HH:mm").format(date);
    final width = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (type == BubbleType.receiverBubble
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          constraints: BoxConstraints(maxWidth: width.width * 0.7,minWidth: width.width * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (ismotorist ? Colors.yellow : Colors.black),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                    fontSize: 19,
                    color: (ismotorist) ? Colors.black : Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                mensagem,
                style: TextStyle(
                    fontSize: 19,
                    color: (ismotorist) ? Colors.black : Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left:width.width*0.5-0.025*mensagem.length),
                child: Text(
                  format,
                  style: TextStyle(
                      fontSize: 19,
                      color: (ismotorist) ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
