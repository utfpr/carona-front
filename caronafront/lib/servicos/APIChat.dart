import 'dart:convert';

import 'package:caronafront/model/Chatmodel.dart';
import 'package:caronafront/servicos/localback.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';

class APIChat {
  static Future<Chat> sendchats(
      {required int raceid, required String msg, required int userid}) async {
    final response = await http.post(
      Uri.parse(Localback.localhost + "message"),
      body: jsonEncode(
        <String, dynamic>{"chatId": raceid, "content": msg, "authorId": userid},
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    final decode = jsonDecode(response.body);
    return Chat(
      msg: msg,
      id: decode["id"],
      author: decode["author"],
      authorid: userid,
      chatid: raceid,
    );
  }

  static Future<List<Chat>> getmensagemchat(int chatid) async {
    final response = await http.get(
        Uri.parse(Localback.localhost + "message/chat/$chatid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final chats = jsonDecode(response.body);
      List<Chat> chatlist = [];
      for (var chat in chats) {
        var chatmsg = Chat(
            msg: chat["content"],
            authorid: chat["authorId"],
            chatid: chat["chatId"],
            author: chat["author"],
            id: chat["id"],
            date: chat["createdAt"]);
        chatlist.add(chatmsg);
      }
      return chatlist;
    } else {
      return [];
    }
  }
}
