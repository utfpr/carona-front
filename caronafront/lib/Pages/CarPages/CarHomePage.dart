import 'package:caronafront/Pages/UserPages/AuthUser.dart';
import 'package:caronafront/Pages/CarPages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/RacePages/RaceHistoricPage.dart';
import 'package:caronafront/Pages/widget/List/Carlist.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/UserPages/EditUser.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

/*
* Nome: Guilherme Almeida Lopes
* 
*/

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
        MaterialPageRoute(builder: (ctx) => HomePage(widget.user)));
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
      floatingActionButton:  FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: addcar,
          child:const Icon(
            Icons.add,
            color: Colors.black,
          ),
          ),
      body: CarList(
        user: widget.user,
        ctx: context,
      ),
    );
  }
}
