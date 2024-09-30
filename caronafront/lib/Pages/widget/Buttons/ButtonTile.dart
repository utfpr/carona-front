import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateExit.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class ButtonTile extends StatelessWidget {
  ButtonTile(
      {required this.race,
      required this.flex,
      required this.format,
      required this.userauth,
      required this.legend,
      super.key});
  Race race;
  User userauth;
  double flex;
  String format;
  String legend;
  void validateexitrace(BuildContext context) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateExit(
              userauth: userauth,
              race: race,
              car: car,
              format: format,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: Colors.white.withOpacity(0.1),
          height: 1,
        ),
        Container(
          height: 0.21 * flex * query.height,
          color: const Color(0xFF0E0B13),
          child: ListTile(
              onTap: () => validateexitrace(context),
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: Text(legend),
                ),
              )),
        ),
      ],
    );
  }
}
