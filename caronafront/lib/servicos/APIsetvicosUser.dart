import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:caronafront/model/Usermoel.dart';
// POST http://localhost:3333/user
// Content-Type: application/json


class APIservicosUser {
  static Future<User?> fectchuser(String id_user)async{
    final response=await http.get(
      Uri.parse("http://localhost:3333/users/"+id_user));
    if (response.statusCode==200) {
      final json_user=jsonDecode(response.body) as Map<String,dynamic>;
      User user=User(json_user["id"] as String , json_user["name"] as String, 
      json_user["email"] as String, json_user["password"] as String, 
      createdAt:json_user["createdAt"] as DateTime?,updateAt:json_user["updatedAt"] as DateTime?);
    }else{
      return null;
    }
  }
  static Future<int> createuser(String name,String email, String password)async{
    final response=await http.post(
      Uri.parse("http://localhost:3333/user"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(<String,String>{
      "name": name,
      "email": email,
      "password": password})
      );
      if (response.statusCode==201) {
        return 0;
      }else{
        return -1;
      }
  }
  static Future<int> deleteuser(String id_user)async {
    final response=await http.delete(
      Uri.parse("http://localhost:3333/users/"+id_user),
      headers:<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      });
    if (response.statusCode==201) {
      return 0;
    } else {
      return -1;
    }
  }
  static Future<int> updateuser(String id_user,String name,String email,String password)async{
    final response=await http.put(
      Uri.parse(" http://localhost:3333/users/"+id_user),
      headers: <String,String>{
       'Content-Type': 'application/json; charset=UTF-8', 
      },
      body:jsonEncode({
      "name": name,
      "email": email,
      "password": password
      })
    );
    if (response.statusCode==201) {
      return 0;
    } else {
      return -1;
    }
  }
}
// ###Update
// PUT3911a759-cce8-4f5b-936d-a16eb2811103
// Content-Type: application/json




// ###Get all
// GET http://localhost:3333/users