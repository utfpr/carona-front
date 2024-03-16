
import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/widget/CarList.dart';
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
    final User user =User("","","","",
    createdAt: null,updateAt: null);
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:RacePage(user)));
  }
}
