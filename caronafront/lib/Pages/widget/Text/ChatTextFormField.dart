import 'package:caronafront/Provider/ProviderChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChatTextFormField extends StatelessWidget {
  ChatTextFormField(
      {super.key,
      required this.text,
      required this.context,
      required this.chatid,
      required this.authorid});
  TextEditingController text;
  BuildContext context;
  int chatid;
  int authorid;
  void send_clear(int authorid, String msg, int raceid) {
    if (msg.isNotEmpty) {
      text.clear();
      final provider = Provider.of<ProviderChat>(context, listen: false);
      provider.sendmensagem(authorid, msg, raceid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Container(
      height: query.size.height * 0.1,
      color: Color.fromARGB(8, 255, 255, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.fromLTRB(query.size.height * 0.01, 0, 0, 0),
                child: TextField(
                  controller: text,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.25),
                      hintText: "Digite uma mensagem...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90))),
                ),
              )),
          SizedBox(
            width: query.size.width * 0.05,
          ),
          Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.yellow,
                child: IconButton(
                    iconSize: 25,
                    onPressed: () => send_clear(authorid, text.text, chatid),
                    icon: Icon(color: Colors.black, Icons.send_rounded)),
              ))
        ],
      ),
    );
  }
}
