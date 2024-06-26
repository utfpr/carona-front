
import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Usermoel.dart';

class Race{

  int id;
  String originpoint;
  String endpoint;
  String timestart;
  User motorist;
  int carid; // carro 
  int seat;
  bool active;
  List<Passager>passenger;
  Race(this.id,this.originpoint,
  this.endpoint,this.motorist,this.carid,
  this.timestart, this.passenger,this.seat,
  this.active,);
}