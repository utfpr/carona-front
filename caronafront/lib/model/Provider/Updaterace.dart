import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class UpadateRace with ChangeNotifier {
  List<Race>? _races;
  get reces=>_races;
  void update(String id)async{
    _races=await APIservicesRace.getallusercar(id);
    notifyListeners();
  }
}