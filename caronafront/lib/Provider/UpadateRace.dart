import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class UpadateRace with ChangeNotifier {
  List<DropdownMenuItem> _cars = [DropdownMenuItem(child: Text(""))];
  List<Race> _racesoffer = [];
  List<DropdownMenuItem<int>> get listseats => _listseat;
  List<DropdownMenuItem> get cars => _cars;
  String id = "";
  List<Race> _racespending = [];
  List<Race> _historicraces = [];
  List<Race> get racespending => _racespending;
  List<Race> get historicraces => _historicraces;
  void historic(int id) async {
    _historicraces = await APIservicesRace.gethistory(id);
    notifyListeners();
  }

  List<Race> get racesoffer => _racesoffer;
  final List<DropdownMenuItem<int>> _listseat = [
    const DropdownMenuItem(
      value: 1,
      child: Text("1"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("2"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("3"),
    ),
    const DropdownMenuItem(
      value: 4,
      child: Text("4"),
    ),
    const DropdownMenuItem(
      value: 5,
      child: Text("5"),
    ),
    const DropdownMenuItem(value: 6, child: Text("6")),
  ];

  void getallraces(int id) async {
    _racesoffer = await APIservicesRace.getalluserraces(id);
    notifyListeners();
  }

  void getracepeding(int id) async {
    _racespending = await APIservicesRace.getracedepeding(id);
    notifyListeners();
  }

  void getlistcar(int id) async {
    final list = await APIservicosCar.getallcar(id);
    Car? cardefault;
    for (var element in list) {
      if (element.mainCar) {
        cardefault = element;
      }
    }
    if (cardefault != null) {
      list.remove(cardefault);
      list.insert(0, cardefault);
    }
    _cars = List.generate(
        list.length,
        (index) => DropdownMenuItem(
              value: list.elementAt(index).id,
              child: Text(list.elementAt(index).modelcolor),
            ));
    id = list.elementAt(0).id;
    notifyListeners();
  }
}
