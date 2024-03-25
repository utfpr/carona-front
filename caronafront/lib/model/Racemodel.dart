import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
class Race{

  String id;
  String originpoint;
  String endpoint;
  DateTime? timestart;
  String userid; // passageiro
  String carid; // carro 
  DateTime? createdAt;
  DateTime? updateAt;

  Race(this.id,this.originpoint,
  this.endpoint,this.userid,this.carid, 
  {required DateTime? timestart,
  required DateTime? createdAt,
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