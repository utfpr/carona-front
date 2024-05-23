// ignore: file_names
import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/List/Historylist.dart';
import 'package:caronafront/Pages/List/OfferList.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Raceregister.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RacePage extends StatefulWidget {
  RacePage(this.user, {super.key});
  final User user;
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  final search = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void exit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void racecadastro() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Raceregister(race: null, user: widget.user)));
  }

  @override
  void dispose() {
    super.dispose();

    search.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
  }

  void profile() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: widget.user)));
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
                      "Caronas rápido e fácil",
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
              "Pegar corrida",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
          Tab(
            icon: Center(
                child: Text(
              "Corridas pendentes",
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
        endDrawer: Drawer(
            width: 0.5 * MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: profile,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, 0, 0, MediaQuery.of(context).size.height - 500),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person_2_outlined),
                            backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                          ),
                          Text("Meu perfil")
                        ],
                      )),
                )),
                Expanded(
                    child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      onTap: exit,
                      title: Text(
                        "Sair",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ))
              ],
            )),
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,
            tab: __tabappbar(Colors.yellow, 5)),
        floatingActionButton: widget.user.havebutton
            ? FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.yellow,
                onPressed: racecadastro)
            : null,
        body: TabBarView(
          children: [
            OfferList(
              user: widget.user,
              provider: provider,
            ),
            HistoryList(user: widget.user,providerrace: provider,)
          ],
        ),
      ),
    );
  }
}
