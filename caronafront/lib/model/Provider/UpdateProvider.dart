import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class UpdateProviderCar with ChangeNotifier{
  late List<Car>? car_value;
  UpdateProviderCar(String id){
    APIservicosCar.getallcar(id).then((value) => car_value=value);
  }
  Future<void>getlitcar(String id) async{
    APIservicosCar.getallcar(id).then((value) => car_value=value);
  }
  void update(){
    notifyListeners();
  }
}