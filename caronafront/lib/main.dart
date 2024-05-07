import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
import 'package:caronafront/model/Usermoel.dart';
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
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context)=>UpdateProviderCar()),
      ChangeNotifierProvider(create: (context)=>UpadateRace())
    ],
    child:  MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:Scaffold(body:CarRegisterPage(user:User("", "Calvo", "", "", createdAt: null, updateAt: null)))
      )
    );
  }
}
