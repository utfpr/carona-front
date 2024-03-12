
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    User user=User();
    final mquery=MediaQuery.of(context);
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:RacePage(user,(){},[Race(),Race(),Race()]) ));
  }
}
