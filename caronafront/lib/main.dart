import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
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
    final car=Car("", "AAAL123", "JACA", "",
                  createdAt: null, updateAt: null);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UpdateProviderCar()),
          ChangeNotifierProvider(create: (context) => UpadateRace())
        ],
        child: MaterialApp(
            theme: ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: Carvalidate(
              tile1:Textinfo(info: car.plate, legend: "Nova placa do carro"),
              tile2:Textinfo(info: car.description, legend: "Nova descrição do carro"),
              funct: () {},
              user: User("", "Calvo", "", "", createdAt: null, updateAt: null),
              car: car,
              buttom: ButtonBarNew(
                title: "Tudo certo!",
                color: Colors.yellow,
                fontsize: 16,
                height: 50,
              ),
            )));
  }
}
