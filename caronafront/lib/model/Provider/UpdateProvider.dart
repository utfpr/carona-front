import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class UpdateProviderCar with ChangeNotifier{
  late List<Car>? car_value=null;

  void update(){
    notifyListeners();
  }
}