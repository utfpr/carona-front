import 'dart:convert';
import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:http/http.dart' as http;

class APIservicesRace {
  static Future<List<Race>?> getalluserraces(String id)async{
    final response = await http.get(
        Uri.parse("http://localhost:3333/race/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> lista = [];
      for (var i = 0; i < json.length;i++) {
        List<Passager> pass=[];
        if (json[i]["userId"]==id) {
          final passagers=json.elementAt(i)["passengers"]; 
          for (var j = 0; j < passagers.length; j++) {
          final passager=json.elementAt(i)["passengers"].elementAt(j); 
            pass.add(Passager(passager["id"], passager["userId"], passager["raceId"]));
          }
          lista.add(Race(json[i]["id"], json[i]["originPoint"], 
          json[i]["endPoint"], json[i]["userId"], 
          json[i]["carId"],json[i]["timeStart"], pass,createdAt: null, updateAt: null));
        }
    }
      return lista;
    }
    return null;
  }
  static Future<List<Race>?> getallrace(String id) async {
    final response = await http.get(
        Uri.parse("http://localhost:3333/race/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> lista = [];
      for (var i = 0; i < json.length;i++) {
        List<Passager> pass=[];
        if (json[i]["userId"]!=id) {
          final passagers=json.elementAt(i)["passengers"]; 
          for (var j = 0; j < passagers.length; j++) {
          final passager=json.elementAt(i)["passengers"].elementAt(j); 
            pass.add(Passager(passager["id"], passager["userId"], passager["raceId"]));
          }
          lista.add(Race(json[i]["id"], json[i]["originPoint"], 
          json[i]["endPoint"], json[i]["userId"], 
          json[i]["carId"],json[i]["timeStart"], pass,createdAt: null, updateAt: null));
        }
    }
      return lista;
    }
    return null;
  }

  static Future<int> deleterace(String id) async{
   final response=await http.delete(Uri.parse("http://localhost:3333/race/"+id)
    ,headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8'
    });
    if (response.statusCode==200) {
      return 0;
    }else{
      return -1;
    }
  }
  static Future<int> updateraces(String originpoint,String endpoint,
  String timestart,String userid,String carid,String seats)async{
    final response=await  http.put(Uri.parse("http://localhost:3333/race"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    body: jsonEncode({"originPoint": originpoint,
    "endPoint": endpoint,
    "timeStart": timestart,
    "userId":userid,
    "seats":int.parse(seats),
    "carId": carid}));
     if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }
  static Future<int> createrace(String originpoint,String endpoint,
  String timestart,String userid,String carid,String seats)async{
    final response=await http.post(Uri.parse("http://localhost:3333/race"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    body: jsonEncode({"originPoint": originpoint,
    "endPoint": endpoint,
    "timeStart": timestart,
    "userId":userid,
    "seats":int.parse(seats),
    "carId": carid}));
    if(response.statusCode==201){
      return 0;
    }else{
      return -1;
    }
  } 
}