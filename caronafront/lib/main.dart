import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  User? user;
  String id="99ffd37e-bde5-4ecf-926c-b8c8321ec504";
  @override
  void initState() {
    super.initState();
    APIservicosUser.fectchuser(id).then((value){
      setState(() {
        user=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final mquery=MediaQuery.of(context);    
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context)=>UpdateProviderCar())
    ],
    child:  MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:RacePage(user!)
      ))
      );
  }
}
