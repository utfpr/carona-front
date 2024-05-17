import 'dart:convert';
import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:http/http.dart' as http;

class APIservicesRace {
  static Future<List<Race>> getalluserraces(String id) async {
    final response = await http.get(Uri.parse("http://localhost:3333/race/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> lista = [];
      for (var race in json) {
        List<Passager> pass = [];
        bool haveuser = false;
        if (race["driver"]["id"] != id) {
          for (var passagers in race["passengers"]) {
            if (passagers["userId"] == id) {
              haveuser = true;
            } else {
              pass.add(Passager(
                  passagers["id"], passagers["userId"], passagers["raceId"]));
            }
          }
          if (haveuser == false && race["seats"] != 0) {
            lista.add(Race(
                race["id"],
                race["originPoint"],
                race["endPoint"],
                User(
                    race["driver"]["id"],
                    race["driver"]["name"],
                    race["driver"]["email"],
                    race["driver"]["password"],
                    race["driver"]["haveCar"],
                    race["driver"]["ra"],
                    createdAt: null,
                    updateAt: null),
                race["carId"],
                race["timeStart"],
                pass,
                race["seats"],
                createdAt: null,
                updateAt: null));
          }
        }
      }
      return lista;
    }
    return [];
  }

  static Future<int> deleterace(String id) async {
    final response = await http.delete(
        Uri.parse("http://localhost:3333/race/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> updateraces(String id, String originpoint, String endpoint,
      String timestart, String seats) async {
    timestart=timestart.replaceAll("Z", "");
    final response = await http.put(
        Uri.parse("http://localhost:3333/race/" + id),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "originPoint": originpoint,
          "seats":int.parse(seats),
          "endPoint": endpoint,
          "timeStart": timestart+"Z",
        }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> createrace(String originpoint, String endpoint,
      String timestart, String userid, String carid, String seats) async {
    final response = await http.post(Uri.parse("http://localhost:3333/race"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "originPoint": originpoint,
          "endPoint": endpoint,
          "timeStart": timestart,
          "userId": userid,
          "seats": int.parse(seats),
          "carId": carid
        }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<Race?> fectchrace(String id) async {
    final response =
        await http.get(Uri.parse("http://localhost:3333/race/" + id));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      List<Passager> listpass = [];
      for (var pass in json["passengers"]) {
        listpass.add(Passager(pass["id"], pass["userId"], pass["raceId"]));
      }
      return Race(
          json["id"],
          json["originPoint"],
          json["endPoint"],
          User(
              id,
              json["driver"]["name"],
              json["driver"]["email"],
              json["driver"]["password"],
              json["driver"]["haveCar"],
              json["driver"]["ra"],
              createdAt: null,
              updateAt: null),
          json["carId"],
          json["timeStart"],
          listpass,
          json["seats"],
          createdAt: null,
          updateAt: null);
    }
    return null;
  }

  static Future<List<Race>> gethistory(String id) async {
    final response =
        await http.get(Uri.parse("http://localhost:3333/race/historic/" + id));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> races = [];
      for (var race in json) {
        List<Passager> pass = [];
        races.add(Race(
            race["id"],
            race["originPoint"],
            race["endPoint"],
            User(race["userId"], "", "", "", false, '',
                createdAt: null, updateAt: null),
            race["carId"],
            race["timeStart"],
            pass,
            race["seats"],
            createdAt: null,
            updateAt: null));
      }
      return races;
    } else {
      return [];
    }
  }
}
