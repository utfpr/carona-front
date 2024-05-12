
import 'package:caronafront/model/Racemodel.dart';
import 'package:flutter/material.dart';

class RaceTile extends StatelessWidget {
  RaceTile(Race this.race, {super.key});
  Race race;
  @override
  Widget build(BuildContext context) {
    final  query=MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: query.height*0.068,
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
                Padding(padding: EdgeInsets.fromLTRB(0,0, 0, 20) ,child: Container(
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
            ],
          )),
        ),
        Container(
          height: query.height*0.058,
          color: Color(0xFF0E0B13),
          child: ListTile(
            title: Text("Oferecida por ${race.motorist.name}",style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.2)),),
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.1),
          height: 1,
        ),
        Container(
          height: query.height*0.065,
          color: Color(0xFF0E0B13),
          child: const ListTile(
            title: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child:Center(
              child: Text("Ver mais informações"),
            ),)
          ),
        )
      ],
    );
  }
}
