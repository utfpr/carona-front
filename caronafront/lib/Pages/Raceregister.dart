import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Racemodel.dart';

class Raceregister extends StatelessWidget {
  Raceregister({required this.user, required this.race, super.key});
  Race? race;
  User user;
  void validate(BuildContext context, Race race, User user) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            race: race,
            user: user,
            back: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Raceregister(user: user, race: null)));
            },
            tile1: Textinfo(info: race.originpoint, legend: "Ponto de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"),
            tile3: Textinfo(info: "", legend: "Carro utilizado"),
            tile4: Textinfo(
                info: race.seat.toString(),
                legend: "Quantidade de acentos disponíveis"),
            tile5: Textinfo(info: race.timestart, legend: "Data da carona"),
            funct: () {},
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  void exit(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  AppBar _buildappbar(
    BuildContext context, {
    required double heightbar,
    required Color color,
    required double radiuscircle,
    required double heightsizebox,
  }) {
    return AppBar(
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Olá, ${user.name}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Caronas rápido e fácil",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])
            ]));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadatePassager>(context);
    provider.initalizetimedate();
    List<DropdownMenuItem> listseat = [
      const DropdownMenuItem(
        child: Text("1"),
        value: 1,
      ),
      const DropdownMenuItem(
        child: Text("2"),
        value: 2,
      ),
      const DropdownMenuItem(
        child: Text("3"),
        value: 3,
      ),
      const DropdownMenuItem(
        child: Text("4"),
        value: 4,
      ),
      const DropdownMenuItem(
        child: Text("5"),
        value: 5,
      ),
      const DropdownMenuItem(child: Text("6"), value: 6),
    ];
    Widget? drawer(BuildContext context) {
      return Drawer(
          width: 0.5 * MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height - 500),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person_2_outlined),
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                          Text("Meu perfil")
                        ],
                      ))),
              Expanded(
                  child: ListView(
                reverse: true,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    onTap: () => exit(context),
                    title: const Text(
                      "Sair",
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ))
            ],
          ));
    }

    final endpoint = (race == null)
        ? TextEditingController()
        : TextEditingController(text: race!.originpoint);
    final beginpoint = (race == null)
        ? TextEditingController()
        : TextEditingController(text: race!.endpoint);
    return Scaffold(
      endDrawer: drawer(context),
      appBar: _buildappbar(
        context,
        heightbar: 0.2,
        radiuscircle: 0.05,
        heightsizebox: 0.01,
        color: Colors.black12,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormFieldTile(
              leght: 150,
              legend: "Qual ponto de partida ?",
              hint: "Ex: UTFPR",
              controller: endpoint),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldTile(
              leght: 150,
              legend: "Qual ponto de partida ?",
              hint: "Ex: UTFPR",
              controller: endpoint),
          const SizedBox(
            height: 10,
          ),
          DropDownTile(
              drop: DropdownButtonFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  items: [],
                  onChanged: (value) {}),
              legend: "Qual o carro utilizado?"),
          const SizedBox(
            height: 10,
          ),
          DropDownTile(
              legend: "Quantos acentos estão disponíveis",
              drop: DropdownButtonFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  value: listseat.elementAt(2).value,
                  items: listseat,
                  onChanged: (value) {})),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 69,child: DropdownButtonFormField(
                decoration:InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))) ,
                  items: provider.days, onChanged: (value) {}),),SizedBox(width: 20,),
              SizedBox(width: 69,child: DropdownButtonFormField(
                decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))) ,
                  items: provider.mouth, onChanged: (value) {}) ,),SizedBox(width: 20,),
              SizedBox(width:89,child:DropdownButtonFormField(
                decoration:InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)) ,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))) ,
                  items: provider.years, onChanged: (value) {}),),
            ],
          ),
        ],
      ),
    );
  }
}
