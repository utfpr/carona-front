import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/List/ChatList.dart';
import 'package:caronafront/Pages/widget/Text/ChatTextFormField.dart';
import 'package:caronafront/Provider/ProviderChat.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage(
      {required this.race,
      required this.userauth,
      required this.chatname,
      super.key});
  Race race;
  User userauth;
  String chatname;
  void back(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage(userauth)));
  }

  String formatpassager() {
    String passenger = " ";
    for (var i = 0; i < race.passenger.length; i++) {
      if (i != 0) {
        passenger = "$passenger,";
      }
      if (i == 3) {
        passenger = "$passenger\n";
      }
      passenger = passenger + race.passenger.elementAt(i).name;
    }
    return passenger;
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final provider = Provider.of<ProviderChat>(context);
    race.motorist.name = chatname;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(query.size.height * 0.2),
          child: AppBarCustom(
            back: () => back(context),
            color: Colors.black12,
            legend: formatpassager(),
            height: query.size.height * 0.2,
            user: race.motorist,
            isyellow: true,
          )),
      body: ChatList(
        textediting: provider.textediting,
        race: race,
        user: userauth,
        upedateProvider: provider,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: query.viewInsets.bottom),
        child: ChatTextFormField(
          text: provider.textediting,
          authorid: userauth.id,
          context: context,
          chatid: race.id,
        ),
      ),
    );
  }
}
