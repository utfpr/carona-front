import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/Raceregister.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/MotoPassCotainer.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/Pages/widget/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryTile extends StatelessWidget {
  HistoryTile(this.userauth, Race this.race,this.flex,{super.key});
  Race race;
  double flex;
  User userauth;
  void back(BuildContext context, User user) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => RacePage(user)));
  }

  void validateexitrace(BuildContext context, Race race, String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            back: () => back(ctx, userauth),
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
            funct: () => exitrace(ctx, race.id),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Sair corrida",
              height: 50,
              fontsize: 16,
            ))));
  }

  void validatedeltecar(BuildContext context, String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            back: () => back(ctx, userauth),
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
            funct: () => deletarrace(ctx, race),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Remover",
              height: 50,
              fontsize: 16,
            ))));
  }

  void exitrace(BuildContext cxt, int raceid) async {
    final json = await APIservicesRace.fectchrace(race.id);
    for (var element in json.passenger) {
      if (element.userId == userauth.id) {
        final reponsedelete = await APIPassenger.deletepasseger(element.id);
        if (reponsedelete == 0) {
          ScaffoldMessenger.of(cxt)
              .showSnackBar(SnackBar(content: Text("liberando acento")));
        } else {
          ScaffoldMessenger.of(cxt).showSnackBar(
              SnackBar(content: Text("Ocorreu um erro tente novamente")));
        }
      }
      back(cxt, userauth);
    }
  }

  void deletarrace(BuildContext ctx, Race race) async {
    final reponsedelete = await APIservicesRace.deleterace(race.id);
    if (reponsedelete == 0) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Corrida deletada")));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content:
              Text("Não foi possível deletar essa corrida tente novamente")));
    }
    back(ctx, userauth);
  }

  void updaterace(Race race, BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(user: userauth, race: race)));
  }

  @override
  Widget build(BuildContext context) {
    String passenger = "";
    String format = race.timestart.substring(8, 10) +
        "/" +
        race.timestart.substring(5, 7) +
        "/" +
        race.timestart.substring(0, 4) +
        "-" +
        race.timestart.substring(11, 16);
    for (var i = 0; i < race.passenger.length; i++) {
      if (i != 0) {
        passenger = passenger + ",";
      }
      if (i == 3) {
        passenger = passenger + "\n";
      }
      passenger = passenger + race.passenger.elementAt(i).name;
    }
    final query = MediaQuery.of(context).size;
    return Card.outlined(child:Card.outlined(elevation: 10,child:Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: query.height * flex,
          color: Color(0xFF0E0B13),
          child: ListTile(
            selectedColor: const Color(0xFF0E0B13),
            title: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start ,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextinfoHistoryTile(
                        info: race.originpoint,
                        legend: "ponto de partida",
                        width: 360,
                        container: DatetimeContainer(label: format)),
                    TextinfoHistoryTile(
                        info: race.endpoint,
                        legend: "destino",
                        width: 295,
                        container:
                            MotoPassContainer(user: userauth, race: race)),
                    SizedBox(height: 5,),
                    Textinfo(
                      info: (passenger != "") ? passenger : "Sem Passageiros",
                      legend: "Passageiro",
                      fontsizeinfo: 12,
                      fontsizelegend: 14,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        (userauth.id == race.motorist.id)
            ? Container(
                color: Color(0xFF0E0B13),
                child: ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      iconSize: 18,
                      onPressed: () => updaterace(race, context),
                      icon: Icon(Icons.edit_outlined),
                    ),
                    IconButton(
                        iconSize: 18,
                        onPressed: () => validatedeltecar(context, format),
                        icon: Icon(Icons.delete_outline))
                  ],
                )),
              )
            : Column(
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.1),
                    height: 1,
                  ),
                  Container(
                    height: 0.21*flex * query.height,
                    color: Color(0xFF0E0B13),
                    child: ListTile(
                        onTap: () => validateexitrace(context, race, format),
                        title: const Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                            child: Text("Ver mais informações"),
                          ),
                        )),
                  )
                ],
              )
      ],
    ),));
  }
}
