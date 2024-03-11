
import 'package:caronafront/Pages/widget/RaceTitle.dart';
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
      home:Scaffold(body: 
      RaceTile(avatar: CircleAvatar(radius: 30.0,),padding: 32.0,
      flexweight: 0.23*mquery.size.height,
      color: Color.fromARGB(255, 32, 32, 32),))
      );
  }
}
