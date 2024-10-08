// ignore_for_file: file_names

import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class UpdateProviderCar with ChangeNotifier{
  List<Car> _listcar=[];
  List<Car> get listcar=>_listcar;
  void getcarlist(int userid)async{
    _listcar=await APIservicosCar.getallcar(userid);
    notifyListeners();
  }
  void deletarcar(int id){
    int tam=listcar.length;
    if (tam!=0) {
      for (var i = 0; i < tam; i++) {
      if (listcar.elementAt(i).id==id) {
        listcar.removeAt(i);
      }
    }
    }
  }
  void cardefault(Car car)async{
    await APIservicosCar.updatecar(car.id,true,car.plate, 
    car.user,car.modelcolor);
    getcarlist(car.user);
  }
}