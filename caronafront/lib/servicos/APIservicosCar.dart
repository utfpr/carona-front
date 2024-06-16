import 'dart:convert';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/servicos/localback.dart';
import 'package:http/http.dart' as http;

class APIservicosCar {
  static Future<int> createcar(
      String plate, String description, String user_id, bool maincar) async {
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

  static Future<int> updatecar(String carid, bool mainCar, String platenew,
      String userid, String descriptionnew) async {
    final response = await http.put(
        Uri.parse(Localback.localhost+"car/" + carid),
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

  static Future<int> deletecar(String carid) async {
    final response = await http.delete(
        Uri.parse(
          Localback.localhost+"car/" + carid,
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
    String id,
  ) async {
    final response = await http.get(
      Uri.parse(Localback.localhost+"car/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final json_car = jsonDecode(response.body) as Map<String, dynamic>;
      return Car(
          json_car["id"] as String,
          json_car["plate"] as String,
          json_car["description"] as String,
          json_car["mainCar"],
          json_car["userId"] as String,
          createdAt: null,
          updateAt: null);
    }
    return Car("", "", "", false, "", createdAt: null, updateAt: null);
  }

  static Future<List<Car>> getallcar(String id) async {
    final response = await http.get(
        Uri.parse(Localback.localhost+"car/user/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Car> lista = [];
      for (var element in json) {
        lista.add(Car(
            element["id"] as String,
            element["plate"] as String,
            element["description"] as String,
            element["mainCar"],
            element["userId"] as String,
            createdAt: null,
            updateAt: null));
      }
      return lista;
    }
    return [];
  }
}
