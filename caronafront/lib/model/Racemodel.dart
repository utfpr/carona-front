
import 'package:caronafront/model/PassagerModel.dart';

class Race{

  String id;
  String originpoint;
  String endpoint;
  String timestart;
  String userid; // passageiro
  String carid; // carro 
  DateTime? createdAt;
  DateTime? updateAt;
  List<Passager>? passenger;
  Race(this.id,this.originpoint,
  this.endpoint,this.userid,this.carid,
  this.timestart, 
  {
  required List<Passager> passenger,
  required DateTime? createdAt,
  required DateTime? updateAt});

  get races => null;

  Map<String,dynamic> tojson(){
    return{
      "id":id,
      "originpoint":originpoint,
      "endpoint":endpoint,
      "timestart":timestart
    };
  }
}