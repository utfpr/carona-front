import 'package:caronafront/model/Racemodel.dart';

class Car{
  final String id;
 
  final String carid;
  final DateTime timestart;
  final DateTime createdAt;
  final DateTime updateAt;
  const Car(this.carid,this.id, 
  {required this.timestart, required this.updateAt,required this.createdAt});
  Car.fromJson(Map<String, dynamic> json): ;
  Map<String,dynamic>tojson()=>{
    
  };
}