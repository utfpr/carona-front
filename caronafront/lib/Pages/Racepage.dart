// ignore: file_names
import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/HistoricPage.dart';
import 'package:caronafront/Pages/List/OfferList.dart';
import 'package:caronafront/Pages/List/Pedinglist.dart';
import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Raceregister.dart';
import 'package:caronafront/Pages/widget/Drawer.dart';
import 'package:caronafront/Pages/EditUser.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RacePage extends StatefulWidget {
  RacePage(this.user, {super.key});
  final User user;
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  void carpage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>CarHomePage(user: widget.user)));
  }
  void historypage(BuildContext context) {
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
              "Pegar carona",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
          Tab(
            icon: Center(
                child: Text(
              "Minhas caronas",
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
