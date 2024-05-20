
import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Usermoel.dart';

class Race{

  String id;
  String originpoint;
  String endpoint;
  String timestart;
  User motorist;
  String carid; // carro 
  int seat;
  DateTime? createdAt;
  DateTime? updateAt;
  bool active;
  List<Passager>passenger;
  Race(this.id,this.originpoint,
  this.endpoint,this.motorist,this.carid,
  this.timestart, this.passenger,this.seat,
  this.active,
  {required DateTime? createdAt,
  required DateTime? updateAt});

  Map<String,dynamic> tojson(){
    return{
      "id":id,
      "originpoint":originpoint,
      "endpoint":endpoint,
      "timestart":timestart
    };
  }
}