import 'dart:convert';
import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/localback.dart';
import 'package:http/http.dart' as http;

class APIservicesRace {
  static Future<List<Race>> getalluserraces(int id) async {
    final response = await http.get(Uri.parse(Localback.localhost+"race/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    
    if (response.statusCode == 200) {
      DateTime date=DateTime.parse(DateTime.now().toIso8601String()+"Z");

      final json = jsonDecode(response.body);
      List<Race> lista = [];
      for (var race in json) {
        List<Passager> pass = [];
        bool haveuser = false;
        DateTime timestart=DateTime.parse(race["timeStart"]);
        if (race["driver"]["id"] != id) {
          for (var passagers in race["passengers"]) {
            if (passagers["userId"] == id) {
              haveuser = true;
            } else {
              pass.add(Passager(passagers["id"], passagers["userId"],
                  passagers["raceId"], passagers["active"],passagers["name"]));
            }
          }
          if (haveuser == false &&
              race["seats"] != 0 &&
              race["active"] == true &&timestart.isAfter(date)) {
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
                    race["driver"]["ra"],),
                race["carId"],
                race["timeStart"],
                pass,
                race["seats"],
                race["active"],));
          }
        }
      }
      return lista;
    }
    return [];
  }

  static Future<int> deleterace(int id) async {
    final response = await http.delete(
        Uri.parse(Localback.localhost+"race/" + "${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> updateraces(int id, String originpoint, String endpoint,
      String timestart, String seats) async {
    timestart = timestart.replaceAll("Z", "");
    final response = await http.put(
        Uri.parse(Localback.localhost+"race/" + "${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "originPoint": originpoint,
          "seats": int.parse(seats),
          "endPoint": endpoint,
          "timeStart": timestart + "Z",
        }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> createrace(String originpoint, String endpoint,
      String timestart, int userid, int carid, String seats) async {
    final response = await http.post(Uri.parse(Localback.localhost+"race"),
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

  static Future<Race> fectchrace(int id) async {
    final response =
        await http.get(Uri.parse(Localback.localhost+"race/" + "${id}"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      List<Passager> listpass = [];
      for (var pass in json["passengers"]) {
        listpass.add(Passager(
            pass["id"], pass["userId"], pass["raceId"], pass["active"],pass["name"]));
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
              json["driver"]["ra"],),
          json["carId"],
          json["timeStart"],
          listpass,
          json["seats"],
          json["active"],);
    }
    return Race(
        id,
        "",
        "",
        User(id, "", "", "", false, "",),
        -1,
        "",
        [],
        3,
        true,);
  }

  static bool cancelrace(Race race, User user) {
    for (var element in race.passenger) {
      if (element.userId == user.id && element.active == false) {
        return true;
      }
    }
    return false;
  }
  static bool userispassager(int iduser,Race race){
    for (var element in race.passenger) {
      if (element.userId == iduser) {
        return true;
      }
    }
    return false;
  }
  static Future<List<Race>> getracedepeding(int id) async {
    final response =
        await http.get(Uri.parse(Localback.localhost+"race/active/" + "${id}"));
    final json = jsonDecode(response.body);
    List<Race> racepedding = [];
    if (response.statusCode == 200) {

      for (var race in json) {
        List<Passager> pass=[];
        for (var passager in race["passengers"]) {
          pass.add(Passager(passager["id"], passager["userId"], passager["raceId"], passager["active"],passager["name"]));
        }
        Race raceobj=Race(
            race["id"],
                race["originPoint"],
                race["endPoint"],
                User(race["userId"], "", "", "", false, '',),
                race["carId"],
                race["timeStart"],
                pass,
                race["seats"],
                race["active"],);
        DateTime datenow=DateTime.parse(DateTime.now().toIso8601String()+"Z");
        DateTime timestart=DateTime.parse(raceobj.timestart);
        if (timestart.isAfter(datenow) ) {
          racepedding.add(raceobj);
        }
      }
      return racepedding.reversed.toList();
    }
    return [];
  }

  static Future<List<Race>> gethistory(int id) async {
    final response =
        await http.get(Uri.parse(Localback.localhost+"race/historic/" + "${id}"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<Race> races = [];
      List<Race> racenotfinalized = [];
      for (var race in json) {
        List<Passager> pass = [];
        final jsonrace = await APIservicesRace.fectchrace(race["id"]);
        for (var passager in jsonrace.passenger) {
          pass.add(Passager(
              passager.id, passager.userId, passager.raceId, passager.active,passager.name));
        }
        if (race["active"]) {
          racenotfinalized.add(Race(
              race["id"],
              race["originPoint"],
              race["endPoint"],
              User(race["userId"], "", "", "", false, '',),
              race["carId"],
              race["timeStart"],
              pass,
              race["seats"],
              race["active"],));
        } else if (!race["active"]) {
          races.add(Race(
              race["id"],
              race["originPoint"],
              race["endPoint"],
              User(race["userId"], "", "", "", false, '',),
              race["carId"],
              race["timeStart"],
              pass,
              race["seats"],
              race["active"],));
        }
      }
      return (racenotfinalized + races).reversed.toList();
    } else {
      return [];
    }
  }
}
