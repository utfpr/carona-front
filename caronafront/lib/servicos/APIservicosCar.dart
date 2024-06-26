import 'dart:convert';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/servicos/localback.dart';
import 'package:http/http.dart' as http;

class APIservicosCar {
  static Future<int> createcar(
      String plate, String description,int  user_id, bool maincar) async {
    final response = await http.post(
      Uri.parse(Localback.localhost+"car"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "plate": plate,
        "description": description,
        "userId": user_id,
        "mainCar": maincar
      }),
    );
    if (response.statusCode == 201) {
      return -1;
    } else {
      return 0;
    }
  }

  static Future<int> updatecar(int carid, bool mainCar, String platenew,
       int userid, String descriptionnew) async {
    final response = await http.put(
        Uri.parse(Localback.localhost+"car/" + "${carid}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "plate": platenew,
          "description": descriptionnew,
          "userId": userid,
          "mainCar": mainCar
        }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> deletecar(int carid) async {
    final response = await http.delete(
        Uri.parse(
          Localback.localhost+"car/" + "${carid}",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<Car> fectchcar(
    int id,
  ) async {
    final response = await http.get(
      Uri.parse(Localback.localhost+"car/" + "${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final json_car = jsonDecode(response.body) as Map<String, dynamic>;
      return Car(
          json_car["id"],
          json_car["plate"] as String,
          json_car["description"] as String,
          json_car["mainCar"],
          json_car["userId"],);
    }
    return Car(-1, "", "", false, -1,);
  }

  static Future<List<Car>> getallcar(int id) async {
    final response = await http.get(
        Uri.parse(Localback.localhost+"car/user/" + "${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Car> lista = [];
      for (var element in json) {
        lista.add(Car(
            element["id"] ,
            element["plate"] as String,
            element["description"] as String,
            element["mainCar"],
            element["userId"] ,));
      }
      return lista;
    }
    return [];
  }
}
