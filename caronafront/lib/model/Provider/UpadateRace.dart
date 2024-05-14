import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class UpadateRace with ChangeNotifier {
  List<DropdownMenuItem> _hours = [];
  List<DropdownMenuItem> _minutes = [];
  List<DropdownMenuItem> _days = [];
  List<DropdownMenuItem> _mouth = [];
  List<DropdownMenuItem> _years = [];
  List<DropdownMenuItem> _cars = [];
  List<Race>_racesoffer=[];
  List<DropdownMenuItem> get listseats => _listseat;
  List<DropdownMenuItem> get hours => _hours;
  List<DropdownMenuItem> get minutes => _minutes;
  List<DropdownMenuItem> get days => _days;
  List<DropdownMenuItem> get mouth => _mouth;
  List<DropdownMenuItem> get years => _years;
  List<DropdownMenuItem> get cars => _cars;
  List<Race> get racesoffer => _racesoffer;
  final List<DropdownMenuItem> _listseat = [
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
  void initalizetimedate() {
    final datetime = DateTime.now();
    _minutes = List.generate(60 - datetime.minute, (index) {
      return DropdownMenuItem(
        child: Text((datetime.minute + index).toString()),
        value: datetime.minute + index,
      );
    });
    _years = List.generate(10, (index) {
      return DropdownMenuItem(
        child: Text((datetime.year + index).toString()),
        value: datetime.year + index,
      );
    });
    _mouth = List.generate(12 - datetime.month, (index) {
      return DropdownMenuItem(
        child: Text((datetime.month + index).toString()),
        value: datetime.month + index,
      );
    });
    _days = List.generate(30 - datetime.day, (index) {
      return DropdownMenuItem(
        child: Text((datetime.day + index).toString()),
        value: datetime.day + index,
      );
    });
  }
  void getallraces(String id)async{
    _racesoffer=await APIservicesRace.getallrace(id);
    notifyListeners();
  }
  void getlistcar(String id) async {
    final list = await APIservicosCar.getallcar(id);
    _cars = List.generate(
        list.length,
        (index) => DropdownMenuItem(
              child: Text(list.elementAt(index).modelcolor),
              value: list.elementAt(index).id,
            ));
  }
}
