import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:flutter/material.dart';

class UpadateRace with ChangeNotifier {
  List<Race>? races;
  void update(String id)async{
    races=await APIservicesRace.getalluserraces(id);
    notifyListeners();
  }
}