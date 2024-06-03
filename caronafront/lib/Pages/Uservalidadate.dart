import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/HistoricPage.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';

class Uservalidate extends StatelessWidget {
  Uservalidate(
      {
      required this.back,
      required User this.user,
      required Textinfo this.tile1,
      required Textinfo this.tile2,
      required Textinfo this.tile3,
      required Textinfo this.tile4,
      required void Function() this.funct,
      required ButtonBarNew this.buttom,
      super.key});
  ButtonBarNew buttom;
  void Function() funct;
  void Function() back;
  Textinfo tile1;
  Textinfo tile2;
  Textinfo tile3;
  Textinfo tile4;
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
          child: AppBarCustom(
            user: user,
            height: 0.2 * MediaQuery.of(context).size.height,
            legend: "Revise as informações",
            back: () => back(),
            color: Colors.black12,
          )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(padding: EdgeInsets.all(16), child: tile1),
            const SizedBox(
              height: 10,
            ),
            Padding(padding: EdgeInsets.all(16), child: tile2),
            const SizedBox(
              height: 5,
            ),
            Padding(padding: EdgeInsets.all(16), child: tile3),
            const SizedBox(
              height: 5,
            ),
            Padding(padding: EdgeInsets.all(16), child: tile4),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: funct,
                child: buttom,
              ),
            )
          ],
        ));
  }

}
