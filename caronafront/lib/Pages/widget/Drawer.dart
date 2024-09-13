import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom(
      {required this.user,
      required this.carpage,
      required this.historypage,
      required this.profile,
      super.key});
  final User user;
  final void Function() profile;
  final void Function() carpage;
  final void Function() historypage;
  void exit(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  Padding titledrawer(
    IconData icon,
    String title,
  ) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Icon(icon),
              backgroundColor: Color.fromARGB(0, 90, 87, 87),
            ),
            Text(title),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 0.5 * MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  onTap: profile,
                  title: titledrawer(Iconsax.personalcard, "Meu Perfil"),
                ),
                ListTile(
                    onTap: carpage,
                    title: titledrawer(
                      Iconsax.car,
                      "Meus Carros",
                    )),
                ListTile(
                    onTap: historypage,
                    title: titledrawer(Iconsax.book, "Histórico"))
              ],
            ),
            Expanded(
                child: ListView(
              reverse: true,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () => exit(context),
                  title: titledrawer(
                      Icons.exit_to_app,
                      "Sair",
                    ),
                ),
              ],
            ))
          ],
        ));
  }
}
