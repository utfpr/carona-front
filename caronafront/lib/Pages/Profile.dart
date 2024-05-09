import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/List/Carlist.dart';
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:caronafront/model/Carmodel.dart';
class Profile extends StatefulWidget {
  Profile({super.key, required this.user});
  User user;

  @override
  State<Profile> createState() => _CarListState();
}

class _CarListState extends State<Profile> {
  List<Car> carlist=[];
  @override
  void dispose() {
    super.dispose();
  }
  void getfrombackallrace(String id)async{
    final list=await APIservicosCar.getallcar(id);
    setState(() {
      carlist=list;
    });

  }
  void racepage(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>RacePage(widget.user)));
  }
  void exit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void addcar() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => CarRegisterPage(
              car: null,
              user: widget.user,
              butt: "Criar carro",
            )));
  }

  AppBar _buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox,
      required TabBar tab}) {
    return AppBar(
        bottom: tab,
        leading: IconButton(onPressed:racepage, icon:Icon(Icons.arrow_back_ios)),
        toolbarHeight: heightbar * MediaQuery.of(context).size.height,
        backgroundColor: color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Seu perfil",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.user.name}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ])
            ]));
  }

  Widget? drawer() {
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person_2_outlined),
                          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
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
                  onTap: exit,
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

  TabBar __tabappbar(Color boxcolor, double indicatorweight) {
    return TabBar(
        indicatorColor: boxcolor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: indicatorweight,
        tabs: const [
          Tab(
            icon: Center(
                child: Text(
              "Meus carros",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
          Tab(
            icon: Center(
                child: Text(
              "Minhas corridas",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    getfrombackallrace(widget.user.id);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: drawer(),
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,
            tab: __tabappbar(Colors.yellow, 5)),
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Colors.yellow,
            onPressed: addcar),
        body: TabBarView(
          children: [CarList(user: widget.user, listcar:carlist,),],
        ),
      ),
    );
  }
}
