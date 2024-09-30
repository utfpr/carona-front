import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class RaceValidateExit extends StatelessWidget {
  RaceValidateExit({required this.userauth,required this.race,required this.car,required this.format,super.key});
  User userauth;
  Car car;
  Race race;
  String format;
  void back(BuildContext ctx, User user) {
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (ctx1) => HomePage(user)));
  }
  void exitrace(BuildContext cxt, int raceid) async {
    final json = await APIservicesRace.fectchrace(race.id);
    for (var element in json.passenger) {
      if (element.userId == userauth.id) {
        final reponsedelete = await APIPassenger.deletepasseger(element.id);
        if (reponsedelete == 0) {
          ScaffoldMessenger.of(cxt)
              .showSnackBar(const SnackBar(content: Text("liberando acento")));
        } else {
          ScaffoldMessenger.of(cxt).showSnackBar(
              const SnackBar(content: Text("Ocorreu um erro tente novamente")));
        }
      }
      back(cxt, userauth);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Racevalidate(
            back: () => back(context, userauth),
            user: userauth,
            tile1: Textinfo(
              info: race.originpoint,
              legend: "Ponto de partida",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            tile2: Textinfo(
              info: race.endpoint,
              legend: "Destino",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            tile3: Textinfo(
              info: car.modelcolor,
              legend: "Carro",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            tile4: Textinfo(
              info: race.seat.toString(),
              legend: "Vagas",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            tile5: Textinfo(
              info: format,
              legend: "Data e hora da partida",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            funct: () => exitrace(context, race.id),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Sair corrida",
              height: 50,
              fontsize: 16,
            ));
  }
}