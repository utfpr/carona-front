import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/Container/ChatContainer.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/List/ChatList.dart';
import 'package:caronafront/Pages/widget/Text/ChatTextFormField.dart';
import 'package:caronafront/Provider/ProviderChat.dart';
import 'package:caronafront/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({required this.race, required this.userauth, super.key});
  Race race;
  User userauth;
  void back(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage(userauth)));
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final provider = Provider.of<ProviderChat>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(query.size.height * 0.2),
          child: AppBarCustom(
            back: () => back(context),
            color: Colors.black12,
            legend: "",
            height: query.size.height * 0.2,
            user: race.motorist,
            isyellow: true,
          )),
      body: ChatList(
        textediting:provider.textediting,
        race: race,
        user: userauth,
        upedateProvider: provider,
      ),
      bottomNavigationBar: Padding(padding:EdgeInsets.only(bottom: query.viewInsets.bottom) ,child: ChatTextFormField(
        text: provider.textediting,
        authorid: userauth.id,
        context: context,
        chatid: race.id,
      ),),
    );
  }
}
