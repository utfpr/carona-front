import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/RacePages/Raceregister.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class RaceValidateUpdate extends StatelessWidget {
  RaceValidateUpdate(
      {required this.user,
      required this.race,
      required this.format,
      required this.list,
      required this.passagers,
      super.key});
  User user;
  Race race;
  String format;
  String passagers;
  List<dynamic> list;
  void sendraceupdateback(
      Race race, BuildContext ctx, List<dynamic> passengers) async {
    final validate = await APIservicesRace.updateraces(race.id,
        race.originpoint, race.endpoint, race.timestart, race.seat.toString());
    for (var i = 0; i < passengers.length; i++) {
      APIPassenger.deletepasseger(passengers.elementAt(i));
    }
    if (validate == 0) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Corrida atualizado !")));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text("Não foi possível atualizar a corrida ")));
    }
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage(user)));
  }

  @override
  Widget build(BuildContext context) {
    return Racevalidate(
        user: user,
        back: () {
          race.timestart = race.timestart.replaceAll("Z", "");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => Raceregister(
                    user: user,
                    race: race,
                  )));
        },
        tile1: Textinfo(
          info: race.originpoint,
          legend: "Local de partida",
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
          info: passagers,
          legend: "Passageiro Removidos",
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
        funct: () => sendraceupdateback(race, context, list),
        buttom: ButtonBarNew(
            color: Colors.yellow,
            title: "Tudo certo!",
            height: 50,
            fontsize: 16));
  }
}
