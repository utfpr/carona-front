import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/model/Carmodel.dart';
class RaceTile extends StatelessWidget {
  RaceTile(Race this.race,
      {required CircleAvatar this.avatar,
      required double this.padding,
      required double this.flexweight,
      required Color this.color,
      super.key});
  Color color;
  Race race;
  CircleAvatar avatar;
  double flexweight;
  double padding;
  Future<Car?> getcar(String id)async{
    return  APIservicosCar.fectchcar(id);
  }
  Future<User?>getuser(String id )async{
    return APIservicosUser.fectchuser(id);
  }
  @override
  Widget build(BuildContext context){
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: flexweight * 0.6,
              color: color,
              child: ListTile(
                leading: avatar,
                title: Text("name"),
                subtitle: Text("plate"),
              ),
            ),
            Container(
              height: 0.45 * flexweight,
              color: color,
              alignment: Alignment.centerLeft,
              child: const ListTile(
                title: Text("description"),
              ),
            ),
            Container(
              height: 0.3 * flexweight,
              alignment: Alignment.centerLeft,
              color: color,
              child: ListTile(
                leading: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("time start"),
                      Text(race.originpoint),
                    ]),
                trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(""),
                      Text(race.endpoint),
                    ]),
              ),
            ),
            Container(
              height: flexweight * 0.4,
              color: color,
              child: const ListTile(
                title: Text(
                  "chat com motorista",
                  textAlign: TextAlign.center,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            )
          ],
        ));
  }
}
