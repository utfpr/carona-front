import 'package:caronafront/Pages/UserPages/AuthUser.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:iconsax/iconsax.dart';
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
/*
  Cria um Drawer Customizado, Com 4 Title.
    1. Meu Perfil: vai para tela de perfil
    2. Meus Carros: vai para tela dos carros cadastrados pelo usuário
    3. Histórico: vai para o histórico de corridas
    4. Sair: vai para o tela de autenticação  
*/ 
class DrawerCustom extends StatelessWidget {
  const DrawerCustom(
      {required this.user,
      required this.carpage,
      required this.historypage,
      required this.profile,
      super.key});
  final User user;// usuario
  final void Function() profile; // rota para tela profile
  final void Function() carpage; // rota para tela de dos carros cadastrados
  final void Function() historypage; // rota para tela de histórico de carros
  void exit(BuildContext context) { // rota para tela de autenticação
    Navigator.of(context) 
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const AuthUser()));
  }

  Padding titledrawer(
    IconData icon,// icone do title
    String title, // nome do campo
  ) { // criar title que vai ser utilzado no drawer
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,// centraliza a linha 
          mainAxisAlignment: MainAxisAlignment.start, // começo da coluna
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(0, 90, 87, 87),
              child: Icon(icon)// cor de fundo do title,
            ),
            Text(title),// texto do title 
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 0.5 * MediaQuery.of(context).size.width,// o drawer vai ter o 50 % do tamanho da tela
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children:  [
                const SizedBox(
                  height: 40,
                ),
                ListTile(
                  onTap: profile,
                  title: titledrawer(Iconsax.personalcard, "Meu Perfil"),// title do perfil
                ),
                ListTile(
                    onTap: carpage,
                    title: titledrawer(
                      Iconsax.car,
                      "Meus Carros",
                    )),// title do Carros
                ListTile(
                    onTap: historypage,
                    title: titledrawer(Iconsax.book, "Histórico"))//Title do Histórico
              ],
            ),
            Expanded( 
                child: ListView(
              reverse: true,//  inverte a lista para ser o ultimo elemento do drawer
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: () => exit(context),// volta para tela de autenticação
                  title: titledrawer(
                      Icons.exit_to_app,
                      "Sair",
                    ),// title da saida 
                ),
              ],
            ))// Cria o title na parte inferiro do Drawer
          ],
        ));
  }
}
