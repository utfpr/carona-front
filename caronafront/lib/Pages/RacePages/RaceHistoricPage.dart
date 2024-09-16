
import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/widget/List/Historylist.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
  /*
  * Nome: Guilherme Almeida Lopes
  *GitHub: alguiguilo098
  *Data de Criação: 14/09/2024
  */
// ignore: must_be_immutable
class HistoricHomePage extends StatefulWidget {
  HistoricHomePage({super.key, required this.user});
  User user;

  @override
  State<HistoricHomePage> createState() => _CarHomePageState();
}
// Tela do histórico de Corridas, Mostrando todas as corridas que o usuário foi passageiro ou Motorista
class _CarHomePageState extends State<HistoricHomePage> {

  void carpage(BuildContext context) { // Rota  para a tela de carros exposição dos carros do usuário 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>CarHomePage(user: widget.user)));
  }
  void racepage() {// Rota para a homePage 
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomePage(widget.user)));
  }
  void profile(BuildContext context) {//Rota para Tela de dados pessoais do usuário
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Profile(user: widget.user)));
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<UpadateRace>(context);// provider para controlar estado da pagina
    return Scaffold(
        endDrawer:DrawerCustom(// cria um drawer coma as rotas definidas para profile e tela de 
        historypage:(){},// desabilita o usuário acesssar uma rota para própria tela 
        profile: ()=>profile(context),
        carpage: ()=>carpage(context),
        user: widget.user,
      ),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.2 * MediaQuery.of(context).size.height),// define o drawer como 20% da altura da tela
          child: AppBarCustom(
            user: widget.user,
            height: 0.2 * MediaQuery.of(context).size.height,
            legend: "Meu histórico de caronas",
            back: ()=>racepage(),// rota de volta para tela anterior
            color: Colors.black12,
          )),
        body:HistoryList(// cria a lista dos cards do histórico
              user: widget.user,
              providerrace: provider,
            ),
        );
  }
}
