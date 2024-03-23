/*
  ###Create
POST http://localhost:3333/race
Content-Type: application/json

{
    "originPoint": "oga maguila",
    "endPoint": "fiorella",
    "timeStart": "20:03",
    "userId": "4118f928-54ba-48f5-a957-65fadaf860c4",
    "carId": "0a32eb3f-c81e-4658-8450-ed6852f8a833"
}

###Update
PUT http://localhost:3333/race/6dd31952-46cf-4e45-9cab-52a66e55d20a
Content-Type: application/json

{
    "originPoint": "oga maguila",
    "endPoint": "fiorella2",
    "timeStart": "20:03",
    "userId": "4118f928-54ba-48f5-a957-65fadaf860c4",
    "carId": "0a32eb3f-c81e-4658-8450-ed6852f8a833"
}

###Delete
DELETE http://localhost:3333/race/

###Get
GET http://localhost:3333/race/

###Get all
GET http://localhost:3333/race/
*/

import 'package:caronafront/model/Racemodel.dart';
import 'package:http/http.dart' as http;

class APIservicesRace {
  static Future<List<Race>?> getallrace() async {
    final response = await http.get(
        Uri.parse("http://localhost:3333/car/user/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      // final json = jsonDecode(response.body);
      List<Race> lista = [];
      // for (var element in json) {
        // lista.add(Race(,createdAt: null, updateAt: null));
      }
      // return lista;
    }
    // return null;
  }
// }