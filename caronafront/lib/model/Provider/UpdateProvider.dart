import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class UpdateProviderCar with ChangeNotifier{
  late Future<List<Car>?>car;
  UpdateProviderCar(String id){
    car=APIservicosCar.getallcar(id);
  }
  Future<List<Car>?>getlitcar(String id) async{
    car=APIservicosCar.getallcar(id);
  }
  void update(){
    notifyListeners();
  }
}