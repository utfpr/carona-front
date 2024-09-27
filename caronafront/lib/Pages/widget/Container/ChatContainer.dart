import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatContainer extends StatelessWidget {
  ChatContainer(
      {required this.mensagem,
      required this.ismotorist,
      required this.name,
      required this.type,
      super.key});
  String name;
  String mensagem;
  bool ismotorist;
  BubbleType type;
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Padding(
      padding: (type == BubbleType.receiverBubble)
          ? EdgeInsets.fromLTRB(0,query.size.height * 0.02, 0, 0)
          : EdgeInsets.fromLTRB((mensagem.length>40)?query.size.width-mensagem.length*4:query.size.width-270,
              query.size.height * 0.02, 0.0,0 ),
      child: ChatBubble(
        margin: EdgeInsets.fromLTRB(0, 0, 0.02 * query.size.height, 0),
        clipper: ChatBubbleClipper1(
          type: type,
        ),
        backGroundColor:
            (ismotorist) ? Colors.yellow : Colors.black12.withOpacity(0.8),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            '$name\n\n$mensagem',
            style: TextStyle(color: (ismotorist) ? Colors.black : Colors.white,fontSize: 18.5),
          ),
        ),
      ),
    );
  }
}
