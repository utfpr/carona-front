import 'package:caronafront/Pages/Chat/ChatPage.dart';
import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateDelete.dart';
import 'package:caronafront/Pages/RacePages/Raceregister.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIChat.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Buttons extends StatelessWidget {
  Buttons(
      {required this.race,
      required this.userauth,
      required this.format,
      super.key});
  Race race;
  User userauth;
  String format;
  void validatedeltecar(BuildContext context, String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateDelete(
              car: car,
              userauth: userauth,
              race: race,
              format: format,
            )));
  }

  void updaterace(Race race, BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(user: userauth, race: race)));
  }

  void chatpage(BuildContext context) async {
    String name = await APIChat.getnamechat(race.id);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ChatPage(
              userauth: userauth,
              race: race,
              chatname: name,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0E0B13),
      child: ListTile(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            color: Colors.yellowAccent.withOpacity(0.75),
            iconSize: 23,
            onPressed: () => updaterace(race, context),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
              iconSize: 23,
              color: Colors.yellowAccent.withOpacity(0.75),
              onPressed: () => validatedeltecar(context, format),
              icon: const Icon(Icons.delete_outline)),
          IconButton(
              iconSize: 23,
              color: Colors.yellowAccent.withOpacity(0.75),
              onPressed: () => chatpage(context),
              icon: const Icon(Iconsax.message))
        ],
      )),
    );
  }
}
