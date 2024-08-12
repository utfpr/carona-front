import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/PagePolitc.dart';
import 'package:caronafront/model/Provider/Providerpassword.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Provider/UpdateProviderText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget  {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UpdateProviderCar()),
          ChangeNotifierProvider(create: (context) => UpadateRace()),
          ChangeNotifierProvider(create: (context) => UpdateProviderText()),
          ChangeNotifierProvider(create: (context)=>Providerpassword())
        ],
        child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: AuthUser()));
  }
}
