import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/TextDateTime.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Racemodel.dart';
import 'package:adoptive_calendar/adoptive_calendar.dart';

class Raceregister extends StatefulWidget {
  Raceregister({required this.user, required this.race, super.key});
  Race? race;
  User user;
  @override
  State<Raceregister> createState() => _RaceregisterState();
}

class _RaceregisterState extends State<Raceregister> {
  int seats = 3;
  String carid = "";
  late TextEditingController beginpoint;
  late DateTime? datetime;
  late TextEditingController endpoint;
  @override
  void initState() {
    super.initState();
    endpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.endpoint);
    beginpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.originpoint);
    seats =
        (widget.race == null) ? 3 : (widget.race!.seat==0)?3:widget.race!.seat;
    carid =(widget.race==null)?"":widget.race!.carid;
    datetime = (widget.race == null)
        ? DateTime.now()
        : DateTime.parse(widget.race!.timestart);
  }
  void sendraceupdateback(Race race,BuildContext ctx)async{
    final validate=await APIservicesRace.updateraces(race.id, race.originpoint, race.endpoint, 
    race.timestart, race.seat.toString());
    if (validate==0) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text("Corrida atualizado !")));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text("Não foi possível atualizar a corrida ")));
    }
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) =>RacePage(widget.user)));
  }
  void sendatacarcreate(Race race, BuildContext ctx) async {
    final validate = await APIservicesRace.createrace(
        race.originpoint,
        race.endpoint,
        race.timestart,
        race.motorist.id,
        race.carid,
        race.seat.toString());
    if (validate == 0) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Corrida cadastrada")));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text("Não foi possível cadastrar corrida")));
    }
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(user: widget.user, race: null)));
  }

  void validateupdaterace(BuildContext context, Race race, User user) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    String format = race.timestart.substring(8, 10) +
        "/" +
        race.timestart.substring(5, 7) +
        "/" +
        race.timestart.substring(0, 4) +
        "-" +
        race.timestart.substring(11, 16);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            race: race,
            user: user,
            back: () {
              race.timestart=race.timestart.replaceAll("Z", "");
              Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Raceregister(user:user,race: race,)));
            },
            tile1: Textinfo(info: race.originpoint, legend: "Ponto de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"),
            tile3: Textinfo(info: car.modelcolor, legend: "Carro utilizado"),
            tile4: Textinfo(
                info: race.seat.toString(),
                legend: "Quantidade de acentos disponíveis"),
            tile5: Textinfo(info: format, legend: "Data da carona"),
            funct: () => sendraceupdateback(race, ctx),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  void validatecraterace(BuildContext context, Race race, User user) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    String format = race.timestart.substring(8, 10) +
        "/" +
        race.timestart.substring(5, 7) +
        "/" +
        race.timestart.substring(0, 4) +
        "-" +
        race.timestart.substring(11, 16);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            race: race,
            user: user,
            back: () {
              Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Raceregister(user: user, race: null)));
            },
            tile1: Textinfo(info: race.originpoint, legend: "Ponto de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Ponto de chegada"),
            tile3: Textinfo(info: car.modelcolor, legend: "Carro utilizado"),
            tile4: Textinfo(
                info: race.seat.toString(),
                legend: "Quantidade de acentos disponíveis"),
            tile5: Textinfo(info: format, legend: "Data da carona"),
            funct: () => sendatacarcreate(race, ctx),
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

  Future<Null> datepicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(datetime!.year, datetime!.month, datetime!.day),
        lastDate:
            DateTime(datetime!.year + 10, datetime!.month, datetime!.day));

    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));
    setState(() {
      datetime =
          DateTime(date!.year, date.month, date.day, time!.hour, time.minute);
    });
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => RacePage(widget.user)));
            },
            icon: Icon(Icons.arrow_back_ios)),
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadateRace>(context);
    provider.getlistcar(widget.user.id);
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
                  controller: beginpoint)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormFieldTile(
                leght: 150,
                legend: "Qual ponto de chegada ?",
                hint: "Ex: Terminal urbano",
                controller: endpoint),
          ),
          SizedBox(
            height:(widget.race==null)? 10:0,
          ),
          (widget.race==null)?Padding(
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
                      value:(widget.race==null)?provider.cars.elementAt(0).value:carid,
                      onChanged: (value) {
                        setState(() {
                          carid = value;
                        });
                      }),
                  legend: "Qual o carro utilizado?")):Text(""),
          SizedBox(
            height:(widget.race==null)? 10:0,
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
                      value: seats,
                      items: provider.listseats,
                      onChanged: (value) {
                        setState(() {
                          seats = value;
                        });
                      }))),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextDateTime(
                  date: datetime!,
                  legend: "Date e hora da corrida",
                  onTap: datepicker)),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: (widget.race != null)
                ? GestureDetector(
                    onTap: () => validateupdaterace(
                        context,
                        Race(
                            widget.race!.id,
                            beginpoint.text,
                            endpoint.text,
                            widget.race!.motorist,
                            carid,
                            datetime!.toIso8601String(),
                            widget.race!.passenger,
                            seats,
                            createdAt: null,
                            updateAt: null),
                        widget.user),
                    child: ButtonBarNew(
                        color: Colors.yellow,
                        title: "Atualizar minha carona",
                        height: 50,
                        fontsize: 16),
                  )
                : GestureDetector(
                    onTap: () => validatecraterace(
                        context,
                        Race(
                            "",
                            beginpoint.text,
                            endpoint.text,
                            widget.user,
                            (carid == "")
                                ? provider.cars.elementAt(0).value
                                : carid,
                            datetime!.toIso8601String() + "Z",
                            [],
                            seats,
                            createdAt: null,
                            updateAt: null),
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
