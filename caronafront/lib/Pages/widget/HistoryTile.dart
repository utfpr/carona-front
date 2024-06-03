
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/Raceregister.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  HistoryTile(this.userauth, Race this.race, {super.key});
  Race race;
  User userauth;
  void back(BuildContext context, User user) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RacePage(user)));
  }

  void validateexitrace(BuildContext context, Race race,String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            race: race,
            back: () => back(ctx, userauth),
            user: userauth,
            tile1: Textinfo(info: race.originpoint, legend: "Ponto de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"),
            tile3: Textinfo(info: car.modelcolor, legend: "Carro utilizado"),
            tile4: Textinfo(
                info: race.seat.toString(),
                legend: "Quantidade de acentos disponíveis"),
            tile5: Textinfo(info: format, legend: "Data da carona"),
            funct: () => exitrace(ctx, race.id),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Sair corrida",
              height: 50,
              fontsize: 16,
            ))));
  }

  void validatedeltecar(BuildContext context,String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            race: race,
            back: () => back(ctx, userauth),
            user: userauth,
            tile1: Textinfo(info: race.originpoint, legend: "Ponto de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"),
            tile3: Textinfo(info: car.modelcolor, legend: "Carro utilizado"),
            tile4: Textinfo(
                info: race.seat.toString(),
                legend: "Quantidade de acentos disponíveis"),
              tile5: Textinfo(info: format, legend: "Data da carona"),
            funct: () => deletarrace(ctx, race),
            buttom: ButtonBarNew(
              color: Colors.red,
              title: "Remover",
              height: 50,
              fontsize: 16,
            ))));
  }

  void exitrace(BuildContext cxt, String raceid) async {
    final json = await APIservicesRace.fectchrace(race.id);
    for (var element in json!.passenger) {
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
    final date=DateTime.parse(DateTime.now().toIso8601String()+"Z");
    final datetimestrat=DateTime.parse(race.timestart);
    final hasfinalizaed=datetimestrat.isAfter(date);
    bool activepassager=true;
    if (hasfinalizaed==false) {
      APIservicesRace.deleterace(race.id);
    }
    for (var element in race.passenger) {
      if (element.userId==userauth.id && element.active==false) {
        activepassager=false;  
      }
    }
    String format = race.timestart.substring(8, 10) +
        "/" +
        race.timestart.substring(5, 7) +
        "/" +
        race.timestart.substring(0, 4) +
        "-" +
        race.timestart.substring(11, 16);
    final query = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: query.height * 0.068,
          color: Color(0xFF0E0B13),
          child: ListTile(
            selectedColor: const Color(0xFF0E0B13),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ponto de partida",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.2), fontSize: 14),
                    ),
                    Text(
                      race.originpoint,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Container(
                    width: 150,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(0.075)),
                    child: Center(
                        child: Text(
                      format,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.068 * query.height,
          color: Color(0xFF0E0B13),
          child: ListTile(
              title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "destino",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.2), fontSize: 14),
                  ),
                  Text(
                    race.endpoint,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              ),
              Container(
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.075)),
                child: Center(
                    child: Text(
                  (race.motorist.id == userauth.id)
                      ? "Motorista"
                      : "Passageiro",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                )),
              )
            ],
          )),
        ),
        (userauth.id == race.motorist.id && race.active==true)
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
                        onPressed: () => validatedeltecar(context,format),
                        icon: Icon(Icons.delete_outline))
                  ],
                    )
                ),
              )
            : Column(
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.1),
                    height: 1,
                  ),
                  Container(
                    height: 0.057 * query.height,
                    color: Color(0xFF0E0B13),
                    child:(hasfinalizaed && race.active==true)?ListTile(
                      onTap: () => (activepassager)?validateexitrace(context,race,format):null,
                      title: Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                            child: (activepassager)?Text("Ver mais informações"):Text("Cancelada")),
                      ),
                    ):ListTile(title:Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                            child: Text("Finalizada")),
                      ),),
                  )
                ],
              )
      ],
    );
  }
}
