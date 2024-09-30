
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';

// ignore: must_be_immutable
class Uservalidate extends StatelessWidget {
  Uservalidate(
      {
      required this.back,
      required this.user,
      required this.tile1,
      required this.tile2,
      required this.tile3,
      required this.tile4,
      required this.funct,
      required this.buttom,
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
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(padding: const EdgeInsets.all(16), child: tile1),
            const SizedBox(
              height: 10,
            ),
            Padding(padding: const EdgeInsets.all(16), child: tile2),
            const SizedBox(
              height: 5,
            ),
            Padding(padding: const EdgeInsets.all(16), child: tile3),
            const SizedBox(
              height: 5,
            ),
            Padding(padding: const EdgeInsets.all(16), child: tile4),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: funct,
                child: buttom,
              ),
            )
          ],
        ));
  }

}
