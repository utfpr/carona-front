import 'package:caronafront/Pages/widget/Container/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/Container/MotoPassContainer.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Pages/widget/Text/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryTileEnd extends StatelessWidget {
  HistoryTileEnd({required this.width ,required this.authuser, required this.race, super.key});
  Race race;
  User authuser;
  double width;
  String passagerformat(){
    String passenger = "";
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
    String passenger = passagerformat();
    String format = "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";
  
    final query = MediaQuery.of(context).size;
    return Card.outlined(
        child: Card.outlined(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: query.height * width,
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
                      TextinfoHistoryTile(
                          info: race.originpoint,
                          width: 360,
                          legend: "Ponto de Partida",
                          container: DatetimeContainer(label: format)),
                      TextinfoHistoryTile(
                          info: race.endpoint,
                          legend: "Destino",
                          width: 295,
                          container:
                              MotoPassContainer(user: authuser, race: race)),
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
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          Container(
            height: 0.2*width * query.height,
            color: Color(0xFF0E0B13),
            child: const ListTile(
                title: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                child: Text("Finalizada"),
              ),
            )),
          )
        ],
      ),
    ));
  }
}
