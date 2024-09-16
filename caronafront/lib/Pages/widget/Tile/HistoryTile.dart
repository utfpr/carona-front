import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateDelete.dart';
import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateExit.dart';
import 'package:caronafront/Pages/RacePages/Raceregister.dart';
import 'package:caronafront/Pages/widget/Container/DateTimeContainer.dart';
import 'package:caronafront/Pages/widget/Container/MotoPassContainer.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Pages/widget/Text/TextinfoHistoryTile.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class HistoryTile extends StatelessWidget {
  HistoryTile(this.userauth, Race this.race, this.flex, {super.key});
  Race race;
  double flex;
  User userauth;

  void validateexitrace(BuildContext context, Race race, String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateExit(
              userauth: userauth,
              race: race,
              car: car,
              format: format,
            )));
  }

  void validatedeltecar(BuildContext context, String format) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateDelete(
              car: car,
              userauth: userauth,
              race: race,
              format: format,
            )));
  }

  void updaterace(Race race, BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(user: userauth, race: race)));
  }

  @override
  Widget build(BuildContext context) {
    String passenger = "";
    String format =
        "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";
    for (var i = 0; i < race.passenger.length; i++) {
      if (i != 0) {
        passenger = "$passenger,";
      }
      if (i == 3) {
        passenger = "$passenger\n";
      }
      passenger = passenger + race.passenger.elementAt(i).name;
    }
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
                                  onPressed: () {},
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
              ? Container(
                  color: Color(0xFF0E0B13),
                  child: ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        color: Colors.yellowAccent.withOpacity(0.75),
                        iconSize: 23,
                        onPressed: () => updaterace(race, context),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                          iconSize: 23,
                          color: Colors.yellowAccent.withOpacity(0.75),
                          onPressed: () => validatedeltecar(context, format),
                          icon: const Icon(Icons.delete_outline)),
                      IconButton(
                          iconSize: 23,
                          color: Colors.yellowAccent.withOpacity(0.75),
                          onPressed: () {},
                          icon: const Icon(Iconsax.message))
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
                      height: 0.21 * flex * query.height,
                      color: Color(0xFF0E0B13),
                      child: ListTile(
                          onTap: () => validateexitrace(context, race, format),
                          title: const Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                              child: Text("Ver mais informações"),
                            ),
                          )),
                    ),
                  ],
                )
        ],
      ),
    ));
  }
}
