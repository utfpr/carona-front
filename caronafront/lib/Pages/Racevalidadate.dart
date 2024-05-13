import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';

class Racevalidate extends StatelessWidget {
  Racevalidate(
      {required Race this.race,
      required this.back,
      required User this.user,
      required Textinfo this.tile1,
      required Textinfo this.tile2,
      required Textinfo this.tile3,
      required Textinfo this.tile4,
      required Textinfo this.tile5,
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
  Textinfo tile5;
  Race race;
  User user;


  void exit(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  AppBar _buildappbar(
    BuildContext context, {
    required double heightbar,
    required Color color,
    required double radiuscircle,
    required double heightsizebox,
  }) {
    return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: back,
        ),
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Olá, ${user.name}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Revise as informações",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])
            ]));
  }

  Widget? drawer(BuildContext context) {
    return Drawer(
        width: 0.5 * MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, 0, MediaQuery.of(context).size.height - 500),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person_2_outlined),
                          backgroundColor: Color.fromARGB(0, 0, 0, 0),
                        ),
                        Text("Meu perfil")
                      ],
                    ))),
            Expanded(
                child: ListView(
              reverse: true,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () => exit(context),
                  title: Text(
                    "Sair",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: drawer(context),
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12),
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
            Padding(padding: EdgeInsets.all(16), child: tile5),
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
