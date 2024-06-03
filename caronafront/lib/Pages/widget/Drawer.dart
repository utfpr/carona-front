import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({required this.user,required this.carpage,required this.historypage,required this.profile,super.key});
  final User user;
  final void Function() profile;  
  final void Function()carpage;
  final void Function() historypage;
  void exit(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
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
                  GestureDetector(
                  onTap: profile,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 10, 0, 0),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person_2_outlined),
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                          Text("Meu perfil"),
                        ],
                      )),
                ),
                ListTile(
                  onTap: carpage,
                  title: Text("Carros",style: TextStyle(fontSize: 15),)),
                ListTile(
                  onTap: historypage,
                  title: Text("Historico",style: TextStyle(fontSize: 15),)),
                ],),
                Expanded(
                    child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      onTap: ()=>exit(context),
                      title: Text(
                        "Sair",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ))
              ],
            ));
  }
}