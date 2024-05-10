import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Provider/UpdateProviderText.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
import 'package:caronafront/model/Racemodel.dart';
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
    final car = Race("", "UTFPR Campo Mourão", "Burguer King", "", "civic",
        "23/04/2024 às 20:56", [], 3,
        createdAt: null, updateAt: null);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UpdateProviderCar()),
          ChangeNotifierProvider(create: (context) => UpadateRace()),
          ChangeNotifierProvider(create: (context) => UpdateProviderText())
        ],
        child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: RacePage(User("", "", "", "",false, "",
                createdAt: null, updateAt: null))
                )
                );
  }
}
