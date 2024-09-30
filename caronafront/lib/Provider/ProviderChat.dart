// ignore: file_names
import 'package:caronafront/model/Chatmodel.dart';
import 'package:caronafront/servicos/APIChat.dart';
import 'package:flutter/material.dart';

class ProviderChat extends ChangeNotifier {
  List<Chat> _list = [];
  String mensagem = "";
  final textediting = TextEditingController();
  ScrollController controller = ScrollController();
  List<Chat> get lista => _list;

  Future<Chat> sendmensagem(int authorid, String msg, int chatid) async {
    Chat chat =
        await APIChat.sendchats(raceid: chatid, msg: msg, userid: authorid);
    return chat;
  }
  void clear(){
    _list.clear();
  }
  void getallmensagem(int id, bool down) async {
    _list = await APIChat.getmensagemchat(id);
    if (down == true) {
      controller.jumpTo(controller.position.maxScrollExtent);
    }
    notifyListeners();
  }
}
