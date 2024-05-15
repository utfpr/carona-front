
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RaceTile extends StatelessWidget {
  RaceTile(this.user,this.race, {super.key});
  Race race;
  User user;
  void back(BuildContext context,User user){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RacePage(user)));
  }
  void passagersenddatabackrace(String passagerid,String race, BuildContext context)async{
    final reponse=await APIPassenger.createpasseger(race, passagerid);
    if (reponse==0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entrou na corrida")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Não possível entrar na corrida")));
    }
    back(context, user);
  }
  void aceptrace(String time,BuildContext context)async{
    Car? car=await APIservicosCar.fectchcar(race.carid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Racevalidate(race: race, back:()=>back(ctx, user), user: race.motorist, 
    tile1: Textinfo(info:race.originpoint, legend: "Ponto de partida"), 
    tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"), 
    tile3: Textinfo(info:car!.modelcolor , legend: "Carro utilizado"), 
    tile4: Textinfo(info:race.seat.toString(), legend: "Quantidade de acentos disponíveis"), 
    tile5: Textinfo(info:time, legend:"Data da carona"), 
    funct:()=>passagersenddatabackrace(user.id, race.id, ctx), 
    buttom: ButtonBarNew(color: Colors.yellow,fontsize: 16,height: 50,title: "Tudo certo !",))));
  }
  @override
  Widget build(BuildContext context) {
    final  query=MediaQuery.of(context).size;
    String format=race.timestart.substring(8,10)+"/"+race.timestart.substring(5,7)+"/"+race.timestart.substring(0,4)+"-"+race.timestart.substring(12,16);
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
                    format,
                    style: TextStyle(
                        fontSize: 12, color: Colors.white),
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
          child: ListTile(
            onTap:()=>aceptrace(format, context),
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
