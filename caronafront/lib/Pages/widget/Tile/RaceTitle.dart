import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Container/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Pages/widget/Text/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RaceTile extends StatelessWidget {
  RaceTile(this.user, this.race, this.flex,this.flexbutton,{super.key});
  Race race;
  User user;
  double flexbutton;
  double flex;
  void back(BuildContext context, User user) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage(user)));
  }

  void passagersenddatabackrace(
      int passagerid, int race, BuildContext context) async {
    final reponse = await APIPassenger.createpasseger(race, passagerid);
    if (reponse == 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Entrou na corrida")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Não possível entrar na corrida")));
    }
    back(context, user);
  }

  void aceptrace(String time, BuildContext context) async {
    Car? car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            back: () => back(ctx, user),
            user: race.motorist,
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
              info: time,
              legend: "Data e hora da carona",
              fontsizeinfo: 14,
              fontsizelegend: 16,
            ),
            funct: () => passagersenddatabackrace(user.id, race.id, ctx),
            buttom: ButtonBarNew(
              color: Colors.yellow,
              fontsize: 16,
              height: 50,
              title: "Tudo certo !",
            ))));
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    String format = "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";
    return Card.outlined(
        child: Card.outlined(
            child: Column(
      children: [
        Container(
          color: Color(0xFF0E0B13),
          height: flex * query.width,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextinfoHistoryTile(
                    info: race.originpoint,
                    legend: "Ponto de Partida",
                    container: DatetimeContainer(label: format),
                    width: 350),
                Textinfo(
                  info: race.endpoint,
                  legend: "Destino",
                  fontsizeinfo: 12,
                  fontsizelegend: 14,
                ),
                Textinfo(
                  info: race.motorist.name,
                  legend: "Motorista",
                  fontsizeinfo: 12,
                  fontsizelegend: 14,
                )
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.1),
          height: 1,
        ),
        Container(
          height: flexbutton* query.height,
          color: const Color(0xFF0E0B13),
          child: ListTile(
              onTap: () => aceptrace(format, context),
              title: const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: Text("Ver mais informações"),
                ),
              )),
        )
      ],
    )));
  }
}
