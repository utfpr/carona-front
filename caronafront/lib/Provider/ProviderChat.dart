// ignore: file_names
import 'package:caronafront/model/Chatmodel.dart';
import 'package:caronafront/servicos/APIChat.dart';
import 'package:flutter/material.dart';

class ProviderChat extends ChangeNotifier {
  List<Chat> _list = [];
  String mensagem="";
  final textediting = TextEditingController();
  List<Chat> get lista => _list;

  Future<Chat> sendmensagem(int authorid, String msg, int chatid) async {
    Chat chat =
        await APIChat.sendchats(raceid: chatid, msg: msg, userid: authorid);
    return chat;
  }

  void getallmensagem(int id, String msg)async {
    _list = await APIChat.getmensagemchat(id);
    notifyListeners();
  }
}
