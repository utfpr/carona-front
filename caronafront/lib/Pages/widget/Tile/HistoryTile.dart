import 'package:caronafront/Pages/Chat/ChatPage.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonTile.dart';
import 'package:caronafront/Pages/widget/Buttons/Buttons.dart';
import 'package:caronafront/Pages/widget/Container/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/Container/MotoPassContainer.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Pages/widget/Text/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class HistoryTile extends StatelessWidget {
  HistoryTile(this.userauth, Race this.race, this.flex, {super.key});
  Race race;
  double flex;
  User userauth;

  void chatpage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ChatPage(
              userauth: userauth,
              race: race,
            )));
  }

  String formatpassager() {
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
    String passenger = formatpassager();
    String format =
        "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";

    final query = MediaQuery.of(context).size;
    return Card.outlined(
        child: Card.outlined(
      elevation: 10,
      child: Column(
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(
                        height: 5,
                      ),
                      Textinfo(
                        info: (passenger != "") ? passenger : "Sem Passageiros",
                        legend: "Integrantes",
                        fontsizeinfo: 12,
                        fontsizelegend: 14,
                      ),
                      (userauth.id != race.motorist.id)
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(
                                  query.width - 130, 0, 0, 0),
                              child: IconButton(
                                  iconSize: 23,
                                  color: Colors.yellowAccent.withOpacity(0.75),
                                  onPressed: () => chatpage(context),
                                  icon: Icon(Iconsax.message)),
                            )
                          : Text("")
                    ],
                  ),
                ],
              ),
            ),
          ),
          (userauth.id == race.motorist.id)
              ? Buttons(
                  race: race,
                  format: format,
                  userauth: userauth,
                )
              : ButtonTile(
                  race: race,
                  flex: flex,
                  userauth: userauth,
                  format: format,
                  legend: "Ver mais informações",
                )
        ],
      ),
    ));
  }
}
