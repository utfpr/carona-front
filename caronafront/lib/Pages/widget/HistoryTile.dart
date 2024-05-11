import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  HistoryTile(this.userauth, Race this.race, {super.key});
  Race race;
  User userauth;
  @override
  Widget build(BuildContext context) {
    final query= MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height:query.height*0.068,
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
                Padding(padding: EdgeInsets.fromLTRB(0,0,0, 30),child: Container(
                  width: 150,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white.withOpacity(0.075)),
                  child: Center(
                      child: Text(
                    race.timestart,
                    style: TextStyle(
                        fontSize: 12, color: Colors.white.withOpacity(0.15)),
                  )),
                ),)
              ],
            ),
          ),
        ),
        Container(
          height: 0.068*query.height,
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
                    "ponto de chegada",
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
                  style: TextStyle(
                      fontSize: 12, color: Colors.white.withOpacity(0.15)),
                )),
              )
            ],
          )),
        ),
        Container(
          height: 0.06*query.height,
          color: Color(0xFF0E0B13),
          child: ListTile(
            title:Padding(padding:EdgeInsets.fromLTRB(0, 0, 0, 40),child:Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 18,
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline),
                ),
                IconButton(
                    iconSize: 18,
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined))
              ],
            )
          ),
        ),
        ),
        Container(
          color: Colors.white.withOpacity(0.1),
          height: 1,
        ),
        Container(
          height: 0.057*query.height,
          color: Color(0xFF0E0B13),
          child: const ListTile(
            title: Center(
              child: Padding(padding:EdgeInsets.fromLTRB(10,0,0, 20),child:Text("Ver mais informações")),
            ),
          ),
        )
      ],
    );
  }
}
