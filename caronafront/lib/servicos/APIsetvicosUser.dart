import 'dart:convert';

import 'package:caronafront/servicos/localback.dart';
import 'package:http/http.dart' as http;
import 'package:caronafront/model/Usermoel.dart';

class APIservicosUser {
  static Future<User> fectchuser(String id_user) async {
    final response =
        await http.get(Uri.parse(Localback.localhost+"user/" + id_user));
    if (response.statusCode == 200) {
      final json_user = jsonDecode(response.body) as Map<String, dynamic>;
      User user = User(json_user["id"], json_user["name"], json_user["email"],
          json_user["password"], json_user["haveCar"], json_user["ra"],
          createdAt: null, updateAt: null);
      return user;
    }
    return User("", "", "", "", false, "", createdAt: null, updateAt: null);
  }

  static Future<List<User>?> getalluser() async {
    final response = await http.get(Uri.parse(Localback.localhost+"user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<User> user = [];
      for (var element in json) {
        user.add(User(element["id"], element["name"], element["email"],
            element["password"], element["havebutton"], element["ra"],
            createdAt: null, updateAt: null));
      }
      return user;
    } else {
      return null;
    }
  }

  static Future<int> createuser(
      User user, String ra, String confirmemail, String confirpassword) async {
    final response = await http.post(Uri.parse(Localback.localhost+"user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": user.name,
          "email": user.email,
          "password": user.password,
          "ra": ra,
          "confirmEmail": confirmemail,
          "confirmPassword": confirpassword
        }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> deleteuser(String id_user) async {
    final response = await http.delete(
        Uri.parse(Localback.localhost+"users/" + id_user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<User?> authra(String ra, String password) async {
    final response = await http.post(Uri.parse(Localback.localhost+"auth/ra"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"ra": ra, "password": password}));
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return User(
          json["user"]["id"],
          json["user"]["name"],
          json["user"]["email"],
          password,
          json["user"]["haveCar"],
          json["user"]["ra"],
          createdAt: null,
          updateAt: null);
    } else {
      return null;
    }
  }

  static Future<User?> auth(String email, String password) async {
    final response = await http.post(Uri.parse(Localback.localhost+"auth"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));
    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return User(
          json["user"]["id"],
          json["user"]["name"],
          json["user"]["email"],
          password,
          json["user"]["haveCar"],
          json["user"]["ra"],
          createdAt: null,
          updateAt: null);
    } else {
      return null;
    }
  }

  static Future<int> updateuser(
      String id_user,
      String name,
      String email,
      String actualPassword,
      String newpassword,
      String confirmNewpassword) async {
    final response =
        await http.put(Uri.parse(Localback.localhost+"user/" + id_user),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "name": name,
              "email": email,
              "password": newpassword,
              "confirmPassword":confirmNewpassword,
              "actualPassword": actualPassword
            }));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }
}
