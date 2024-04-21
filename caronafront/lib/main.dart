import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
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

  @override
  Widget build(BuildContext context) {
    final mquery=MediaQuery.of(context);    
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context)=>UpdateProviderCar()),
      ChangeNotifierProvider(create: (context)=>UpadateRace())
    ],
    child:  MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:AuthUser()))
      );
  }
}
