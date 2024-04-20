import 'dart:convert';
import 'package:caronafront/model/Carmodel.dart';
import 'package:http/http.dart' as http;

class APIservicosCar {
  static String? getidplate(List<Car>?list,String plate){
    if (list==null) {
      return null;
    }else{
      for (var element in list) {
      if (element.plate==plate) {
        return element.id;
      }
     }
  }
    }
    
  static Future<int> createcar(
      String plate, String description, 
      String user_id,int seats) async {
    final response = await http.post(
      Uri.parse("http://localhost:3333/car"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "plate": plate,
        "description": description,
        "userId": user_id
      }),
    );
    if (response.statusCode == 201) {
      return -1;
    } else {
      return 0;
    }
  }

  static Future<int> updatecar(String carid, String platenew, String userid,
      String descriptionnew) async {
    final response = await http.put(
        Uri.parse("http://localhost:3333/car/" + carid),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "plate": platenew,
          "description": descriptionnew,
          "userId": userid,
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
          "http://localhost:3333/car/" + carid,
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

  static Future<Car?> fectchcar(
    String id,
  ) async {
    final response = await http.get(
      Uri.parse("http://localhost:3333/car/" + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    if (response.statusCode == 200) {
      final json_car = jsonDecode(response.body) as Map<String, dynamic>;
      return Car(json_car["id"] as String, json_car["plate"] as String,
          json_car["description"] as String, json_car["id"] as String,
          createdAt: json_car["createdAt"] as DateTime?,
          updateAt: json_car["updateAt"] as DateTime?);
    } else {
      return null;
    }
  }

  static Future<List<Car>?> getallcar(String id) async {
    final response = await http.get(
        Uri.parse("http://localhost:3333/car/user/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Car> lista = [];
      for (var element in json) {
        lista.add(Car(element["id"] as String, element["plate"] as String,
            element["description"] as String, element["userId"] as String,
            createdAt: null, updateAt: null));
      }
      return lista; 
    }
    return null;
  }
}

  






// ###Delete
// DELETE http://localhost:3333/car

// ###Get
// GET http://localhost:3333/car/

// ###Get all
// GET http://localhost:3333/car/user/4118f928-54ba-48f5-a957-65fadaf860c4







