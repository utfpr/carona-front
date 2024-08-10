
import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/List/Historylist.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/widget/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HistoricHomePage extends StatefulWidget {
  HistoricHomePage({super.key, required this.user});
  User user;

  @override
  State<HistoricHomePage> createState() => _CarHomePageState();
}

class _CarHomePageState extends State<HistoricHomePage> {

  void carpage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>CarHomePage(user: widget.user)));
  }
  void racepage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RacePage(widget.user)));
  }
  void profil(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Profile(user: widget.user)));
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UpadateRace>(context);
    return Scaffold(
        endDrawer:DrawerCustom(
        historypage:(){},
        profile: ()=>profil(context),
        carpage: ()=>carpage(context),
        user: widget.user,
      ),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
          child: AppBarCustom(
            user: widget.user,
            height: 0.2 * MediaQuery.of(context).size.height,
            legend: "Meu histórico de caronas",
            back: ()=>racepage(),
            color: Colors.black12,
          )),
        body:HistoryList(
              user: widget.user,
              providerrace: provider,
            ),
        );
  }
}
