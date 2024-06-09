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
    GlobalKey<ScaffoldState> key=GlobalKey<ScaffoldState>();
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
        body:   Padding(padding: EdgeInsets.symmetric(horizontal: 50),child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Textinfo(info: user.name, legend: "Nome"),
            SizedBox(
              height: 40,
            ),
            Textinfo(info: user.email, legend: "E-mail"),
            SizedBox(
              height: 40,
            ),
            Textinfo(info: user.ra, legend: "RA"),
            SizedBox(
              height: 40,
            ),
            Textinfo(info: providercar.listcar.length.toString(), legend: "Carros cadastrados"),
            SizedBox(
              height: 10,
            ),
          ],
        )),floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
          onPressed:()=> edituser(context)),
        );
  }
}
