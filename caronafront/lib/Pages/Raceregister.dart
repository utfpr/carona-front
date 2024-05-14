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

class Raceregister extends StatefulWidget {
  Raceregister({required this.user, required this.race, super.key});
  Race? race;
  User user;
  @override
  State<Raceregister> createState() => _RaceregisterState();
}

class _RaceregisterState extends State<Raceregister> {
  int seats = 3;
  String carid="";
  int day = DateTime.now().day;
  int mouth = DateTime.now().month;
  int years = DateTime.now().year;
  int hour = DateTime.now().hour;
  int minutes = DateTime.now().minute;
  @override
  void initState() {
    super.initState();
  }

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
                "Olá, ${widget.user.name}",
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
    final provider = Provider.of<UpadateRace>(context);
    provider.initalizetimedate();
    provider.getlistcar(widget.user.id);
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

    final endpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.originpoint);
    final beginpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.endpoint);
    carid=provider.cars.elementAt(0).value;
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
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormFieldTile(
                  leght: 150,
                  legend: "Qual ponto de partida ?",
                  hint: "Ex: UTFPR",
                  controller: endpoint)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormFieldTile(
                leght: 150,
                legend: "Qual ponto de partida ?",
                hint: "Ex: Terminal urbano",
                controller: endpoint),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropDownTile(
                  drop: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      items: provider.cars,
                      onChanged: (value) {setState(() {
                        
                      });}),
                  legend: "Qual o carro utilizado?")),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropDownTile(
                  legend: "Quantos acentos estão disponíveis",
                  drop: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      value: provider.listseats.elementAt(2).value,
                      items: provider.listseats,
                      onChanged: (value) {
                        setState(() {
                          seats = value;
                        });
                      }))),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text("Qual a data de saída?")),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 69,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      items: provider.days,
                      onChanged: (value) {setState(() {
                        day=value;
                      });}),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 69,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      items: provider.mouth,
                      onChanged: (value) {setState(() {
                        mouth=value;
                      });}),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 89,
                  child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      items: provider.years,
                      onChanged: (value) {setState(() {
                        years=value;
                      });}),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Qual o horário de saída?")),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 69,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10))),
                      items: provider.hours,
                      onChanged: (value) {setState(() {
                        hour=value;
                      });},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ":",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 69,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10))),
                        items: provider.minutes,
                        onChanged: (value) {setState(() {
                          hour=value;
                        });}),
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                onTap: () => validate(
                    context,
                    Race("", beginpoint.text, endpoint.text, widget.user,carid,
                        DateTime(years,mouth,day,hour,minutes).toIso8601String(), [], seats, createdAt: null, updateAt: null),
                    widget.user),
                child: ButtonBarNew(
                    color: Colors.yellow,
                    title: "Criar minha carona",
                    height: 50,
                    fontsize: 16)),
          )
        ],
      ),
    );
  }
}
