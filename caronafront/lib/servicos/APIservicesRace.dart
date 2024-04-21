import 'dart:convert';
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
      for (var element in json) {
          if (element["userId"]==id) {
            lista.add(Race(element["id"], element["originPoint"], 
          element["endPoint"], element["userId"], 
          element["carId"],element["timeStart"],createdAt: null, updateAt: null));
          }
        
      }
      return lista;
    }
    return null;
  }
  static Future<List<Race>?> getallrace(String id) async {
    final response = await http.get(
        Uri.parse("http://localhost:3333/race"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> lista = [];
      for (var element in json) {
        if (element["userId"]!=id) {
          lista.add(Race(element["id"], element["originPoint"], 
          element["endPoint"], element["userId"], 
          element["carId"],element["timeStart"],createdAt: null, updateAt: null));
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