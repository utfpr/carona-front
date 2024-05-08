import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';

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
          ChangeNotifierProvider(create: (context) => UpadateRace())
        ],
        child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: Profile(
                user: User("", "Calvo", "", "",
                    createdAt: null, updateAt: null))));
  }
}
