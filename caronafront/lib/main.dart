
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    final mquery=MediaQuery.of(context);
    final user=User(
          "861fff11-ff10-4c05-86fc-9f932670ba1b",
          "Guilherme Almeida Lopes",
          "claysono2@email.com","A1234567.a",
          createdAt: DateTime.now(),
          updateAt: DateTime.now()
        );    
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context)=>UpdateProviderCar("861fff11-ff10-4c05-86fc-9f932670ba1b"))
    ],
    child:  MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:RacePage(user)
      ))
      );
  }
}
