import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class UpdateProviderCar with ChangeNotifier{
  List<Car> _listcar=[];
  List<Car> get listcar=>_listcar;
  void getcarlist(String userid)async{
    _listcar=await APIservicosCar.getallcar(userid);
    notifyListeners();
  }
  void deletarcar(String id){
    int tam=listcar.length;
    for (var i = 0; i < tam; i++) {
      if (listcar.elementAt(i).id==id) {
        listcar.removeAt(i);
      }
    }
  }
  void cardefault(Car car)async{
    await APIservicosCar.updatecar(car.id, car.mainCar,car.plate, 
    car.user,car.modelcolor);
    getcarlist(car.user);
  }
}