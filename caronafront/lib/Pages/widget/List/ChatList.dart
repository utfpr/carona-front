// ignore: file_names
import 'dart:async';
import 'package:caronafront/Pages/widget/Container/ChatContainer.dart';
import 'package:caronafront/Provider/ProviderChat.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatList extends StatefulWidget {
  ChatList(
      {required this.textediting,
      required this.user,
      required this.race,
      required this.upedateProvider,
      super.key});
  Race race;
  User user;
  TextEditingController textediting;
  ProviderChat upedateProvider;
  @override
  State<ChatList> createState() => _ChatLisState();
}

class _ChatLisState extends State<ChatList> {
  
  late Timer time;
  @override
  void initState() {
      widget.upedateProvider.getallmensagem(widget.race.id, true);
    time = Timer.periodic(const Duration(seconds: 1), (t) {
      widget.upedateProvider.getallmensagem(widget.race.id, false);
    });
    super.initState();
  }
  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          controller: widget.upedateProvider.controller,
          itemCount:widget.upedateProvider.lista.length ,
          itemBuilder: (context, index) {
          return ChatContainer(
              time: widget.upedateProvider.lista.elementAt(index).date!,
              mensagem: widget.upedateProvider.lista.elementAt(index).msg,
              ismotorist: widget.race.motorist.id ==
                  widget.upedateProvider.lista.elementAt(index).authorid,
              name: widget.upedateProvider.lista.elementAt(index).author,
              type: (widget.upedateProvider.lista.elementAt(index).authorid ==
                      widget.user.id)
                  ? BubbleType.sendBubble
                  : BubbleType.receiverBubble);
        }),
        onRefresh: () async =>
            widget.upedateProvider.getallmensagem(widget.race.carid, true));
  }
}
