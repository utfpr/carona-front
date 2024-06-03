import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/HistoricPage.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/widget/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/Pages/edituser.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({required this.user, super.key});
  final User user;
  void carpage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: user)));
  }

  void historypage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HistoricHomePage(user: user)));
  }

  void back(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => RacePage(user)));
  }

  void edituser(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => EditUser(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    final providercar=Provider.of<UpdateProviderCar>(context);
    final providerrace=Provider.of<UpadateRace>(context);
    providercar.getcarlist(user.id);
    providerrace.getcarpeding(user.id);
    return Scaffold(
        endDrawer: DrawerCustom(
          user: user,
          profile: () {},
          carpage: () => carpage(context),
          historypage: () => historypage(context),
        ),
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(0.2 * MediaQuery.of(context).size.height),
            child: AppBarCustom(
              legend: "Perfil",
              user: user,
              height: 0.2 * MediaQuery.of(context).size.height,
              back: () => back(context),
              color: Colors.black12,
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Textinfo(info: user.name, legend: "nome")),
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.fromLTRB(70, 0,00, 0), child: Textinfo(info: user.email, legend: "nome")),
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Textinfo(info: user.ra, legend: "Ra")),
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 0), child: Textinfo(info: providercar.listcar.length.toString(), legend: "Quantidade de Carros")),
            SizedBox(
              height: 40,
            ),Padding(padding: EdgeInsets.fromLTRB(0, 0, 15, 0), child: Textinfo(info: providerrace.racespending.length.toString() , legend: "Corridas")),
            SizedBox(
              height: 10,
            ),
          ],
        ),floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
          onPressed:()=> edituser(context)),
        );
  }
}
