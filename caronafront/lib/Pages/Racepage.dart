
import 'package:caronafront/Pages/CarList.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/Dados.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RacePage extends StatefulWidget {
  RacePage(this.user, {super.key});
  final User user;
  late Future<List<Race>?> listrace=Future<Null>.value(null);
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  final search = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  bool isSelected = false;
  bool isSelectedof1 = false;
  bool isSelectedof2 = false;
  bool isSelectedof3 = false;

  late FocusNode focusNode;
  late FocusNode focusNodeoffer1;
  late FocusNode focusNodeoffer2;
  late FocusNode focusNodeoffer3;
  
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNodeoffer1 = FocusNode();
    focusNodeoffer2 = FocusNode();
    focusNodeoffer3 = FocusNode();
    focusNode.addListener(onfocuschancesearch);
    focusNodeoffer1.addListener(onfocuschanceoff1);
    focusNodeoffer2.addListener(onfocuschanceoff2);
    focusNodeoffer3.addListener(onfocuschanceoff3);
    widget.listrace=APIservicesRace.getallrace();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    focusNodeoffer1.dispose();
    focusNodeoffer2.dispose();
    focusNodeoffer3.dispose();
    search.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    focusNodeoffer1.removeListener(onfocuschanceoff1);
    focusNodeoffer1.removeListener(onfocuschanceoff2);
    focusNodeoffer1.removeListener(onfocuschanceoff3);
  }

  Column mgsnogetall(String msg) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          msg,
          style: TextStyle(color: Colors.white.withOpacity(0.1), fontSize: 12),
        ),
        SizedBox(
          child: Icon(
            Icons.clear_rounded,
            size: 100,
            color: Colors.white.withOpacity(0.1),
          ),
          width: 100,
          height: 200,
        )
      ],
    );
  }
  void onfocuschanceoff1() {
    if (controller1.text.isNotEmpty) {
      setState(() {
        isSelectedof1 = true;
      });
      return;
    }
    setState(() {
      isSelectedof1 = focusNodeoffer1.hasFocus;
    });
  }

  void onfocuschanceoff2() {
    if (controller2.text.isNotEmpty) {
      setState(() {
        isSelectedof2 = true;
      });
      return;
    }
    setState(() {
      isSelectedof2 = focusNodeoffer2.hasFocus;
    });
  }

  void onfocuschanceoff3() {
    if (controller3.text.isNotEmpty) {
      setState(() {
        isSelectedof3 = true;
      });
      return;
    }
    setState(() {
      isSelectedof3 = focusNodeoffer3.hasFocus;
    });
  }

  void onfocuschancesearch() {
    if (search.text.isNotEmpty) {
      setState(() {
        isSelected = true;
      });
      return;
    }
    setState(() {
      isSelected = focusNode.hasFocus;
    });
  }

  Column offerride(
      {required double height,
      required TextEditingController controller1,
      required TextEditingController controller2,
      required TextEditingController controller3}) {
    final bar1 = _buildsearchappbar(1,
        title: "De onde estamos saindo?",
        controller: controller1,
        icon: Icon(Icons.search),
        iconcolor: Colors.white,
        fillColor: Colors.black87,
        subtitle: "Insira o endereço");
    final bar2 = _buildsearchappbar(2,
        title: "Para onde estamos indo?",
        controller: controller2,
        icon: const Icon(Icons.search),
        iconcolor: Colors.white,
        fillColor: Colors.black87,
        subtitle: "Insira o endereço");

    final bar3 = _buildsearchappbar(3,
        title: "Quando vamos?",
        controller: controller3,
        icon: Icon(Icons.calendar_today),
        iconcolor: Colors.white,
        fillColor: Colors.black87,
        subtitle: "");

    final button = buttonbar(
        height: 50, fontsize: 20, 
        color: Colors.yellow, title: "Criar Rota");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onLongPress: request,
          child: bar1,
        ),
        SizedBox(
          height: height,
        ),
        GestureDetector(
          onLongPress: request,
          child: bar2,
        ),
        SizedBox(
          height: height,
        ),
        GestureDetector(
          onLongPress: request,
          child: bar3,
        ),
        SizedBox(
          height: height,
        ),
        GestureDetector(
          onTap: ()async{
            int del=await APIservicesRace.createcar(controller1.text,
             controller2.text, controller3.text, 
             widget.user.id, Dados.car.id);
             if (del==0) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: 
                  Text("Corrida agendada")
                  ));
                } else {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Corrida não agendada"))
                );
             }
          },
          child: button,
        )
      ],
    );
  }

  Container buttonbar(
      {required Color color,
      required String title,
      required double height,
      required double fontsize}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(180)),
      child: Text(
        title,
        style: TextStyle(fontSize: fontsize, color: Colors.white),
      ),
    );
  }

  void request() {
    if (isSelected == true) {
      focusNode.requestFocus();
    } else if (focusNodeoffer1.hasFocus == true) {
      focusNodeoffer1.requestFocus();
    } else if (isSelectedof2 == true) {
      focusNodeoffer2.requestFocus();
    } else if (isSelectedof3 == true) {
      focusNodeoffer3.requestFocus();
    }
  }

  AppBar _buildappbar(BuildContext context,
      {required double heightbar,
      required Color color,
      required double radiuscircle,
      required double heightsizebox,
      required TabBar tab}) {
    return AppBar(
      bottom: tab,
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.all(15),
          child: CircleAvatar(
            radius: radiuscircle * MediaQuery.of(context).size.height,
            backgroundColor: Color.fromARGB(221, 51, 39, 153),
          ),
        )
      ],
      toolbarHeight: heightbar * MediaQuery.of(context).size.height,
      backgroundColor: color,
      title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [Text("Olá, Guilherme"), Text("Caronas rápido e fácil")]),
    );
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
              "Procurar",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          ),
          Tab(
            icon: Center(
                child: Text(
              "Oferecer",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
          )
        ]);
  }

  TextFormField _buildsearchappbar(int searchnum,
      {required String title,
      required TextEditingController controller,
      required Icon icon,
      required Color iconcolor,
      required Color fillColor,
      required String subtitle}) {
    Column labeltext;
    if (subtitle != "") {
      labeltext = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  color: Color.fromARGB(188, 255, 255, 255), fontSize: 10),
            ),
          ]);
    } else {
      labeltext = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  color: Color.fromARGB(188, 255, 255, 255), fontSize: 10),
            ),
          ]);
    }
    if (searchnum == 1) {
      return TextFormField(
        focusNode: focusNodeoffer1,
        controller: controller1,
        showCursor: false,
        decoration: InputDecoration(
          fillColor: fillColor,
          prefixIcon: icon,
          label: isSelectedof1 ? null : labeltext,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(180))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(180)),
          ),
        ),
      );
    } else if (searchnum == 2) {
      return TextFormField(
        focusNode: focusNodeoffer2,
        controller: controller,
        showCursor: false,
        decoration: InputDecoration(
          fillColor: fillColor,
          prefixIcon: icon,
          label: isSelectedof2 ? null : labeltext,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(180))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(180)),
          ),
        ),
      );
    } else if (searchnum == 3) {
      return TextFormField(
        focusNode: focusNodeoffer3,
        controller: controller3,
        showCursor: false,
        decoration: InputDecoration(
          fillColor: fillColor,
          prefixIcon: icon,
          label: isSelectedof3 ? null : labeltext,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(180))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(180)),
          ),
        ),
      );
    }
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      showCursor: false,
      decoration: InputDecoration(
        fillColor: fillColor,
        prefixIcon: icon,
        label: isSelected ? null : labeltext,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(180))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(180)),
        ),
      ),
    );
  }

  GNav _build_gnav(
      {required Color backgroundColor,
      required Color tabgroundColor,
      required void Function(int) tabchange,
      required double iconsize,
      required int index}) {
    return GNav(
      tabs: const [
        GButton(
          icon: Icons.home_filled,
          text: "Home",
        ),
        GButton(
          icon: Icons.chat_rounded,
          text: "chat",
        ),
        GButton(
          icon: Icons.person_2_outlined,
          text: "profile",
        )
      ],
      selectedIndex: index,
      gap: 8,
      duration: Duration(milliseconds: 900),
      onTabChange: tabchange,
      iconSize: iconsize,
      tabBorderRadius: 25,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      backgroundColor: backgroundColor,
      tabBackgroundColor: tabgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mquery = MediaQuery.of(context);
    final msgnofound=Center(child:mgsnogetall("Nao encontrado corridas"));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,
            tab: __tabappbar(Colors.yellow, 5)),
        body: TabBarView(
          children: [
            FutureBuilder<List<Race>?>(
                    future: widget.listrace, 
                    builder:(context,list){
                      if (list.hasData) {
                        return ListView.builder(
                        itemCount: list.data!.length,
                        itemBuilder: (context,index){
                          return Container(
                            height:100,
                            child: ListTile(
                              title: Text(list.data!.elementAt(index).originpoint),
                              subtitle: Text(list.data!.elementAt(index).endpoint),
                              trailing:Text(list.data!.elementAt(index).timestart),
                              ),
                          );
                      });
                      }
                      return msgnofound;
                    } ),
            Padding(
            padding: EdgeInsets.all(32),
            child: offerride(
            height: 18, 
            controller1: controller1, 
            controller2: controller2, 
            controller3: controller3))
          ],
            
        
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: _build_gnav(
              backgroundColor: const Color.fromARGB(3, 0, 0, 0),
              tabgroundColor: Colors.white12,
              iconsize: 20,
              index: 0,
              tabchange: (index) async {
                if (index == 1) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => CarList(
                            user: widget.user,gnav: _build_gnav(
                            backgroundColor: Color.fromARGB(3, 0, 0, 0), 
                            tabgroundColor: Colors.white12, tabchange: (index){
                              if (index==0) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context)=>RacePage(widget.user))
                                  );
                              }
                            }, 
                            iconsize: 20, index: 1),
                          )));
                }
              }),
        ),
      ),
    );
  }
}
