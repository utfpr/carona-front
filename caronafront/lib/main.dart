import 'package:caronafront/Pages/CarList.dart';
import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    final mquery=MediaQuery.of(context);
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:CarList(
        user:User(
          "861fff11-ff10-4c05-86fc-9f932670ba1b",
          "861fff11-ff10-4c05-86fc-9f932670ba1b",
          "claysono2@email.com","A1234567.a",
          createdAt: DateTime.now(),
          updateAt: DateTime.now()
        )
      )
      ));
  }
}
