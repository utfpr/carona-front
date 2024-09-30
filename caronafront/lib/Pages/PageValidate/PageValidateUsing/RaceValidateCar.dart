import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/RacePages/Raceregister.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class RaceValidateCreate extends StatelessWidget {
  RaceValidateCreate(
      {required this.user,
      required this.race,
      required this.car,
      required this.format,
      super.key});
  User user;
  Race race;
  Car car;
  String format;
  void sendatacarcreate(Race race, BuildContext ctx) async {
    final validate = await APIservicesRace.createrace(
        race.originpoint,
        race.endpoint,
        race.timestart,
        race.motorist.id,
        race.carid,
        race.seat.toString());
    if (validate == 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text("Corrida cadastrada")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text("Não foi possível cadastrar corrida")));
    }
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(user: user, race: null)));
  }

  @override
  Widget build(BuildContext context) {
    return Racevalidate(
        user: user,
        back: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) => Raceregister(user: user, race: null))),
        tile1: Textinfo(
          info: race.originpoint,
          legend: "Local  de partida",
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
          legend: "Data e hora de partida",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        funct: () => sendatacarcreate(race, context),
        buttom: ButtonBarNew(
            color: Colors.yellow,
            title: "Tudo certo!",
            height: 50,
            fontsize: 16));
  }
}
