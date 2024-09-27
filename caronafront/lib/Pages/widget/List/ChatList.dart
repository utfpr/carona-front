import 'dart:async';

import 'package:caronafront/Pages/widget/Container/ChatContainer.dart';
import 'package:caronafront/Provider/ProviderChat.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
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

  late Timer time;
  @override
  State<ChatList> createState() => _ChatLisState();
}

class _ChatLisState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
    widget.time = Timer.periodic(Duration(seconds: 2), (t) {
      widget.upedateProvider.getallmensagem(widget.race.id,widget.textediting.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.upedateProvider.lista.length,
                (ctx, index) => ChatContainer(
                    mensagem: widget.upedateProvider.lista.elementAt(index).msg,
                    ismotorist: widget.race.motorist.id ==
                        widget.upedateProvider.lista.elementAt(index).authorid,
                    name: widget.upedateProvider.lista.elementAt(index).author,
                    type: (widget.upedateProvider.lista
                                .elementAt(index)
                                .authorid ==
                            widget.user.id)
                        ? BubbleType.sendBubble
                        : BubbleType.receiverBubble),
              ),
            ),
          ],
        ),
        onRefresh: () async => widget.upedateProvider
            .getallmensagem(widget.race.carid, ""));
  }
}
