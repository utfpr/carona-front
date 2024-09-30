import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateCar.dart';
import 'package:caronafront/Pages/PageValidate/PageValidateUsing/RaceValidateUpdate.dart';
import 'package:caronafront/Pages/RacePages/RaceHistoricPage.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/Multiselect.dart';
import 'package:caronafront/Pages/widget/Text/TextDateTime.dart';
import 'package:caronafront/Pages/widget/Text/TextFormField.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/Racemodel.dart';

// ignore: must_be_immutable
class Raceregister extends StatefulWidget {
  Raceregister({required this.user, required this.race, super.key});
  Race? race;
  User user;
  @override
  State<Raceregister> createState() => _RaceregisterState();
}

class _RaceregisterState extends State<Raceregister> {
  int seats = 3;
  late int carid;
  late TextEditingController beginpoint;
  late DateTime? datetime;
  late TextEditingController endpoint;
  late List<dynamic> listpassager;
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
    carid = (widget.race == null) ? -1 : widget.race!.carid;
    datetime = (widget.race == null)
        ? DateTime.now().add(Duration(minutes: 5))
        : DateTime.parse(widget.race!.timestart);
    listpassager = [];
  }



  Future<String> getnamepassagersdelete(List<dynamic> list) async {
    String passengers = "";
    List<int> usersid = [];
    List<User> passenger = [];
    for (var element in list) {
      for (var passenger in widget.race!.passenger) {
        if (element == passenger.id) {
          usersid.add(passenger.userId);
          break;
        }
      }
    }
    for (var id in usersid) {
      final response = await APIservicosUser.fectchuser(id);
      passenger.add(response);
    }
    for (var i = 0; i < passenger.length; i++) {
      if (i != 0) {
        passengers += ",";
      }
      passengers += passenger.elementAt(i).name;
    }
    return passengers;
  }

  void validateupdaterace(
      BuildContext context, Race race, User user, List<dynamic> list) async {
    String passenger = await getnamepassagersdelete(list);
    String format = "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateUpdate(format: format,passagers: passenger,user: user,list: list,race:race)));
  }

  void back() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage(widget.user)));
  }

  void validatecraterace(BuildContext context, Race race, User user) async {
    Car car = await APIservicosCar.fectchcar(race.carid);
    String format =
        "${race.timestart.substring(8, 10)}/${race.timestart.substring(5, 7)}/${race.timestart.substring(0, 4)}-${race.timestart.substring(11, 16)}";
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RaceValidateCreate(
              user: user,
              race: race,
              car: car,
              format: format,
            )));
  }

  Future<Null> datepicker(
      int carid, int seat, String originPoint, String endPoint) async {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime(datetime!.year, datetime!.month, datetime!.day),
        lastDate:
            DateTime(datetime!.year + 10, datetime!.month, datetime!.day));

    TimeOfDay? time = await showTimePicker(
        // ignore: use_build_context_synchronously
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
    final sizedbox = SizedBox(
      height: 30,
    );
    final sizedbox30andnull = SizedBox(
      height: (widget.race == null) ? 30 : 0,
    );
    final multiselect_formfield = MultidropdownCustom(
        onsave: (value) {
          setState(() {
            listpassager = value;
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: ListView(
            children: [
              TextFormFieldTile(
                  value: validatename,
                  leght: 150,
                  legend: "Ponto de Partida",
                  hint: "Ex: UTFPR",
                  controller: beginpoint),
              sizedbox,
              TextFormFieldTile(
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
                  onTap: () =>
                      datepicker(carid, seats, beginpoint.text, endpoint.text)),
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
                            ),
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
                      onTap: () => validatecraterace(
                          context,
                          Race(
                            -1,
                            beginpoint.text,
                            endpoint.text,
                            widget.user,
                            (carid == -1)
                                ? provider.cars.elementAt(0).value
                                : carid,
                            "${datetime!.toIso8601String()}Z",
                            [],
                            seats,
                            true,
                          ),
                          widget.user),
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
