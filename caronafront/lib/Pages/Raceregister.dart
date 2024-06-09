import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/HistoricPage.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/Multiselect.dart';
import 'package:caronafront/Pages/widget/TextDateTime.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
  String carid = "";
  late TextEditingController beginpoint;
  late DateTime? datetime;
  late TextEditingController endpoint;
  late List<dynamic>  listpassager;
  @override
  void initState() {
    super.initState();
    endpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.endpoint);
    beginpoint = (widget.race == null)
        ? TextEditingController()
        : TextEditingController(text: widget.race!.originpoint);
    seats = (widget.race == null)
        ? 3
        : (widget.race!.seat == 0)
            ? 3
            : widget.race!.seat;
    carid = (widget.race == null) ? "" : widget.race!.carid;
    datetime = (widget.race == null)
        ? DateTime.now().add(Duration(minutes: 5))
        : DateTime.parse(widget.race!.timestart);
    listpassager=[];
  }

  void sendraceupdateback(Race race, BuildContext ctx,List<dynamic>passengers) async {
    final validate = await APIservicesRace.updateraces(race.id,
        race.originpoint, race.endpoint, race.timestart, race.seat.toString());
    for (var i = 0; i < passengers.length; i++) {
      APIPassenger.deletepasseger(passengers.elementAt(i));
    }
    if (validate == 0) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Corrida atualizado !")));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text("Não foi possível atualizar a corrida ")));
    }
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RacePage(widget.user)));
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
  Future<String> getnamepassagersdelete(List<dynamic>list)async{
    String passengers="";
    List<String> usersid=[];
    List<User> passenger=[];
    for (var element in list) {
      for (var passenger in widget.race!.passenger) {
        if (element==passenger.id) {
          usersid.add(passenger.userId);
          break;
        }
      }
    }
    for (var id in usersid) {
      final response=await APIservicosUser.fectchuser(id);
      passenger.add(response);
    }
    for (var i = 0; i < passenger.length; i++) {
      if (i!=0) {
        passengers+=",";
      }
      passengers+=passenger.elementAt(i).name;
    }
    return passengers;
  }
  void validateupdaterace(
      BuildContext context, Race race, User user, List<dynamic> list) async {
    String passenger=await getnamepassagersdelete(list);
    String format = race.timestart.substring(8, 10) +
        "/" +
        race.timestart.substring(5, 7) +
        "/" +
        race.timestart.substring(0, 4) +
        "-" +
        race.timestart.substring(11, 16);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            user: user,
            back: () {
              race.timestart = race.timestart.replaceAll("Z", "");
              Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Raceregister(
                        user: user,
                        race: race,
                      )));
            },
            tile1: Textinfo(info: race.originpoint, legend: "Local de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Destino"),
            tile3: Textinfo(info: passenger, legend: "Passageiro Removidos"),
            tile4: Textinfo(info: race.seat.toString(), legend: "Vagas"),
            tile5: Textinfo(info: format, legend: "Data e hora da partida"),
            funct: () => sendraceupdateback(race, ctx,list),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  void back() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RacePage(widget.user)));
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
            user: user,
            back: () {
              Navigator.of(ctx).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => Raceregister(user: user, race: null)));
            },
            tile1:
                Textinfo(info: race.originpoint, legend: "Local  de partida"),
            tile2: Textinfo(info: race.endpoint, legend: "Destino"),
            tile3: Textinfo(info: car.modelcolor, legend: "Carro"),
            tile4: Textinfo(info: race.seat.toString(), legend: "Vagas"),
            tile5: Textinfo(info: format, legend: "Data e hora de partida"),
            funct: () => sendatacarcreate(race, ctx),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Tudo certo!",
                height: 50,
                fontsize: 16))));
  }

  Future<Null> datepicker(
      String carid, int seat, String originPoint, String endPoint) async {
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
      beginpoint.text = originPoint;
      endpoint.text = endPoint;
      seats = seat;
      carid = carid;
    });
  }

  String? validatename(String? name) {
    if (name!.isEmpty) {
      return "Campo Vazio";
    }
    return null;
  }

  void profile() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: widget.user)));
  }

  void carpage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: widget.user)));
  }

  void historypage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => HistoricHomePage(user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadateRace>(context);
    provider.getlistcar(widget.user.id);
    final sizedbox=SizedBox(height: 30,);
    final sizedbox30andnull= SizedBox(height: (widget.race == null) ? 30 : 0,);
    final multiselect_formfield = MultidropdownCustom(
        onsave: (value){
          setState(() {
            listpassager=value;
          });
        },
        legend: "",
        okbutton: "Deletar",
        cancelbutton: "Sair",
        title: "Removidos",
        race: widget.race);
    return Scaffold(
        endDrawer: DrawerCustom(
          user: widget.user,
          profile: profile,
          carpage: carpage,
          historypage: historypage,
        ),
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
            child: AppBarCustom(
              legend:
                  (widget.race == null) ? "Nova Carona" : "Atualizar Carona",
              user: widget.user,
              height: 0.2 * MediaQuery.of(context).size.height,
              back: back,
              color: Colors.black12,
            )),
        body: Form(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
          child: ListView(
            children: [
              TextFormFieldTile(
                      value: validatename,
                      leght: 150,
                      legend: " Local de partida",
                      hint: "Ex: UTFPR",
                      controller: beginpoint),
              sizedbox,TextFormFieldTile(
                    value: validatename,
                    leght: 150,
                    legend: "Destino",
                    hint: "Ex: Terminal urbano",
                    controller: endpoint),
              sizedbox30andnull,
              (widget.race == null)
                  ? DropDownTile(
                          list: provider.cars,
                          value: (widget.race == null)
                              ? provider.cars.elementAt(0).value
                              : carid,
                          onChanged: (value) {
                            setState(() {
                              carid = value;
                            });
                          },
                          legend: "Carro")
                  : Text(""),
             sizedbox30andnull,
              DropDownTile<int>(
                      legend: "Vagas",
                      value: seats,
                      list: provider.listseats,
                      onChanged: (value) {
                        setState(() {
                          seats = value;
                        });
                      }),
              sizedbox,
              TextDateTime(
                      date: datetime!,
                      legend: "Data e hora da partida",
                      onTap: () => datepicker(
                          carid, seats, beginpoint.text, endpoint.text)),
              sizedbox,
              (widget.race != null) ? multiselect_formfield : Text(""),
              sizedbox,
              (widget.race != null)
                    ? GestureDetector(
                        onTap: () {
                          validateupdaterace(
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
                                  true,
                                  createdAt: null,
                                  updateAt: null),
                              widget.user,
                              listpassager);
                        },
                        child: ButtonBarNew(
                            color: Colors.yellow,
                            title: "Atualizar  carona",
                            height: 50,
                            fontsize: 16),
                      )
                    : GestureDetector(
                        onTap: () {
                          validatecraterace(
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
                                  true,
                                  createdAt: null,
                                  updateAt: null),
                              widget.user);
                        },
                        child: ButtonBarNew(
                            color: Colors.yellow,
                            title: "Criar Carona",
                            height: 50,
                            fontsize: 16)),
            ],
          ),
        )));
  }
}
