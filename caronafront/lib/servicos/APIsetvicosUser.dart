import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:caronafront/model/Usermoel.dart';

class APIservicosUser {
  static Future<User?> fectchuser(String id_user) async {
    final response =
        await http.get(Uri.parse("http://localhost:3333/users/" + id_user));
    if (response.statusCode == 200) {
      final json_user = jsonDecode(response.body) as Map<String, dynamic>;
      User user = User(json_user["id"] as String, json_user["name"] as String,
          json_user["email"] as String, json_user["password"] as String,
          createdAt: json_user["createdAt"] as DateTime?,
          updateAt: json_user["updatedAt"] as DateTime?);
    } else {
      final list_user = await getalluser();
      if (list_user == null) {
        final response =
            await createuser("Calvo","guiguigui098@gmail.com","alegria05");
        final list_user_second = await getalluser();
        return list_user_second!.first;
      } else {
        return list_user.first;
      }
    }
  }

  static Future<List<User>?> getalluser() async {
    final response = await http.get(Uri.parse("http://localhost:3333/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<User> user = [];
      for (var element in json) {
        user.add(User(element["id"], element["name"], element["email"],
            element["password"],
            createdAt: null, updateAt: null));
      }
      return user;
    } else {
      return null;
    }
  }

  static Future<int> createuser(String email,String name, String password) async {
    final response = await http.post(Uri.parse("http://localhost:3333/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
          jsonEncode(<String, String>{
            "name": name,
            "email": email, 
            "password": password,}));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<int> deleteuser(String id_user) async {
    final response = await http.delete(
        Uri.parse("http://localhost:3333/users/" + id_user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }

  static Future<User?> auth(String name, String password) async {
    final response = await http.post(Uri.parse("http://localhost:3333/auth"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{"email": name, "password": password}));
    if (response.statusCode == 201) {
      final json=jsonDecode(response.body);
      return User(json["user"]["id"],json["user"]["name"],
      json["user"]["email"],password, createdAt: null, updateAt: null);
    } else {
      return null;
    }
  }

  static Future<int> updateuser(
      String id_user, String name, String email, String password) async {
    final response = await http.put(
        Uri.parse(" http://localhost:3333/users/" + id_user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"name": name, "email": email, "password": password}));
    if (response.statusCode == 201) {
      return 0;
    } else {
      return -1;
    }
  }
}
