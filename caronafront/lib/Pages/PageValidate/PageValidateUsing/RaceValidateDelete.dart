import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class RaceValidateDelete extends StatelessWidget {
  RaceValidateDelete({super.key,required this.car,required this.race,required this.format,required this.userauth});
  String format;
  Race race;
  Car car;
  User userauth;
  void back(BuildContext ctx, User user) {
    Navigator.of(ctx)
        .pushReplacement(MaterialPageRoute(builder: (ctx1) => HomePage(user)));
  }
  
  void deletarrace(BuildContext ctx, Race race) async {
    final reponsedelete = await APIservicesRace.deleterace(race.id);
    if (reponsedelete == 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Corrida deletada")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content:
              Text("Não foi possível deletar essa corrida tente novamente")));
    }
    back(ctx, userauth);
  }

  @override
  Widget build(BuildContext context) {
    return Racevalidate(
            back: () => back(context,userauth),
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
              legend: "Data e hora  da partida",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            funct: () => deletarrace(context, race),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Remover",
              height: 50,
              fontsize: 16,
            ));
  }
}