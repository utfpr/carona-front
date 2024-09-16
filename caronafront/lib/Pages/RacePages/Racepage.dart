// ignore: file_names
import 'package:caronafront/Pages/RacePages/RaceHistoricPage.dart';
import 'package:caronafront/Pages/widget/List/OfferList.dart';
import 'package:caronafront/Pages/widget/List/Pedinglist.dart';
import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/RacePages/Raceregister.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/Drawer.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:provider/provider.dart';
 /*
  * Nome: Guilherme Almeida Lopes
  *GitHub: alguiguilo098
  *Data de Criação: 14/09/2024
  */
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage(this.user, {super.key});
  final User user;
  @override
  State<HomePage> createState() => _RacePageState();
}

class _RacePageState extends State<HomePage> {
  void carpage(BuildContext context) { // Rota para ir para tela  Mostra de carros 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>CarHomePage(user: widget.user)));
  }
  void historypage(BuildContext context) { // Rota Para ir para Histórico de Corridasy
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HistoricHomePage(user: widget.user)));
  }
  void profile(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Profile(user: widget.user)));
  }
  void racecadastro() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(race: null, user: widget.user)));
  }

  AppBar _buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox,
      required TabBar tab}) {
    return AppBar(
        bottom: tab,
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Olá, ${widget.user.name}",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Carona Solidária",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])
            ]));
  }

  TabBar __tabappbar(Color boxcolor, double indicatorweight) {
    return TabBar(
        indicatorColor: boxcolor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: indicatorweight,
        tabs: const [
          Tab(
            icon: Center(
                child: Text(
              "Corridas",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
          Tab(
            icon: Center(
                child: Text(
              "Minhas Corridas",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadateRace>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: DrawerCustom(
            carpage: () => carpage(context),
            profile: ()=>profile(context),
            historypage: () => historypage(context),
            user: widget.user),
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,
            tab: __tabappbar(Colors.yellow, 5)),
        floatingActionButton: widget.user.havebutton
            ? Padding(padding:EdgeInsets.symmetric(vertical: 10) ,child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.yellow,
                onPressed: racecadastro),)
            : null,
        body: TabBarView(
          children: [
            OfferList(
              user: widget.user,
              provider: provider,
            ),
            PedingList(
              user: widget.user,
              ctx: context,
            )
          ],
        ),
      ),
    );
  }
}
