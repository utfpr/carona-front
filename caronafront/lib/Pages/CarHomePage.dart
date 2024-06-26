import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/HistoricPage.dart';
import 'package:caronafront/Pages/List/Carlist.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/EditUser.dart';
import 'package:caronafront/Pages/widget/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class CarHomePage extends StatefulWidget {
  CarHomePage({super.key, required this.user});
  User user;

  @override
  State<CarHomePage> createState() => _CarHomePageState();
}

class _CarHomePageState extends State<CarHomePage> {
  void historc() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HistoricHomePage(user: widget.user)));
  }

  void profil() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Profile(user: widget.user)));
  }
  void racepage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RacePage(widget.user)));
  }

  void exit() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const AuthUser()));
  }

  void addcar() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => CarRegisterPage(
              car: null,
              user: widget.user,
              butt: "Criar carro",
            )));
  }

  void edituser(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => EditUser(user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerCustom(
        historypage: historc,
        profile: profil,
        carpage: (){},
        user: widget.user,
      ),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
          child: AppBarCustom(
            user: widget.user,
            height: 0.2 * MediaQuery.of(context).size.height,
            legend: "Meus Carros",
            back: () => racepage(),
            color: Colors.black12,
          )),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
          onPressed: addcar),
      body: CarList(
        user: widget.user,
        ctx: context,
      ),
    );
  }
}
