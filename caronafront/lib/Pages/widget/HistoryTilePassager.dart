import 'package:caronafront/Pages/widget/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/MotoPassCotainer.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/Pages/widget/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class HistoryTileEnd extends StatelessWidget {
  HistoryTileEnd({required this.authuser, required this.race, super.key});
  Race race;
  User authuser;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: query.height * 0.25,
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
                        legend: "ponto de partida",
                        container: DatetimeContainer(label: format)),
                    SizedBox(
                      height: 20,
                    ),
                    TextinfoHistoryTile(
                        info: race.endpoint,
                        legend: "destino",
                        container:
                            MotoPassContainer(user: authuser, race: race)),
                    SizedBox(
                      height: 20,
                    ),
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
          height: 0.057 * query.height,
          color: Color(0xFF0E0B13),
          child: ListTile(
              title: const Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
              child: Text("Finalizada"),
            ),
          )),
        )
      ],
    );
  }
}
