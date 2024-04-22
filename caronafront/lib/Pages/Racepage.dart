import 'package:caronafront/Pages/CarList.dart';
import 'package:caronafront/Pages/PassagerList.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/Updaterace.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RacePage extends StatefulWidget {
  RacePage(this.user, {super.key});
  final User user;
  late Future<List<Race>?> listrace = Future<Null>.value(null);
  late Future<List<Car>?> listcar = Future<Null>.value(null);
  String selectedCar = "";
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  final search = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  String daterace="";
  String timerace="";
  bool isSelected = false;
  bool isSelectedof1 = false;
  bool isSelectedof2 = false;
  bool isSelectedof3 = false;

  late FocusNode focusNode;
  late FocusNode focusNodeoffer1;
  late FocusNode focusNodeoffer2;
  late FocusNode focusNodeoffer3;
  
  Future displayDatePicker(BuildContext context) async {
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(9999),
  );

  if (date != null) {
    setState(() {
      daterace = DateFormat("yyyy-MM-dd").format(date)
;
    });
  }
 }

 Future displayTimePicker(BuildContext context) async {
  var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now());

  if (time != null) {
    setState(() {
      timerace= "${time.hour}:${time.minute}:00Z";
    });
  }
}
  Future<int?> aceptrace(String id) async {
    return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content:Container(
              height: 100,
              child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(child:Text(
                  "Você gostaria de aceitar essa corrida?",
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: ()async {
                      int value=await APIPassenger.createpasseger(id, widget.user.id);
                      Navigator.of(context).pop(value);
                    }, child: Text("yes")),
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text("no"))
                  ],
                )
              ],
            ),
          )
          );
        });
  }

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
    widget.listrace = APIservicesRace.getallrace(widget.user.id);
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
  SliverList caruser(){
    final providerrace=Provider.of<UpadateRace>(context);
    providerrace.update(widget.user.id);
    final msgnofound = Center(child: mgsnogetall("Nao encontrado corridas"));
    return SliverList(
      delegate: SliverChildBuilderDelegate(
      childCount:providerrace.races!.length ,
      (ctx,index){
          return GestureDetector(
          child: ListTile(
            title: Text(providerrace.races!.elementAt(index).originpoint),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(providerrace.races!.elementAt(index).endpoint),
                Text(providerrace.races!.elementAt(index).timestart)
              ],
            ),
            trailing: IconButton(
              onPressed: ()async{
                final response=await APIservicesRace.deleterace(providerrace.races!.elementAt(index).id);
                providerrace.update(widget.user.id);
              },icon: Icon(Icons.delete),
            ),
          ),
        );
      })
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

  ListView offerride(
      {required double height,
      required TextEditingController controller1,
      required TextEditingController controller2,
      required TextEditingController controller3}) {
    final car= APIservicosCar.getallcar(widget.user.id);
    int del=0;
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
        title: "Quantidade de acentos ?",
        controller: controller3,
        icon: Icon(Icons.event_seat_rounded),
        iconcolor: Colors.white,
        fillColor: Colors.black87,
        subtitle: "");
    final button = ButtonBarNew(
        height: 50,
        fontsize: 20,
        color: Color(0xFF695E19),
        title: "Criar Rota");
    final cotainertime=Container(
      height: 50,
      decoration:BoxDecoration(color: Color(0xFF695E19), borderRadius: BorderRadius.circular(180)),
      child: Center(child:Text("Time",style: TextStyle(fontSize: 20)),),
      );
    final cotainerdate=Container(
      decoration:BoxDecoration(color: Color(0xFF695E19), borderRadius: BorderRadius.circular(180)),
      height: 50,
      child: Center(
        child:Text("Data",style: TextStyle(fontSize: 20),
      ),
    ),);
    return ListView(
      children: [
        FutureBuilder(future:car, builder: (context,snapshot){
        List<DropdownMenuItem<String>>?listdrop=[];
        if (snapshot.hasData) {
          for (var i = 0; i < snapshot.data!.length; i++) {
            if (snapshot.hasData) {
              listdrop.add(DropdownMenuItem<String>(
                child: Text(snapshot.data!.elementAt(i).plate),
                value: snapshot.data!.elementAt(i).plate,
              ));
            }
        }}
          return DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.black12,
                  
                ),
                dropdownColor: Color.fromARGB(255, 7, 7, 7),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.selectedCar = newValue!;
                  });
                },
                items:listdrop );
        }),SizedBox(height:10 ,),
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
        ),SizedBox(height: height,),
        GestureDetector(
          onTap: (){
            displayDatePicker(context);
          },
          child: cotainerdate,
        ),
        SizedBox(height: height,),
        GestureDetector(
          onTap: (){
            displayTimePicker(context);
          },
          child: cotainertime,
        ),
        SizedBox(height: 2*height,),
        GestureDetector(
          onTap: () async {
            final list=await APIservicosCar.getallcar(widget.user.id);
            String? codigo=APIservicosCar.getidplate(list,widget.selectedCar);
            del=await APIservicesRace.createrace(controller1.text, controller2.text,daterace+"T"+timerace, widget.user.id,codigo!, controller3.text);
            if (del == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Corrida agendada")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Corrida não agendada")));
            }
          },
          child: button,
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Olá, ${widget.user.name}"),
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Caronas rápido e fácil"),
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
          ),Tab(
            icon: Center(
                child: Text(
              "Corridas",
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

  GNav _build_gnav({
    required Color backgroundColor,
    required Color tabgroundColor,
    required void Function(int) tabchange,
    required double iconsize,
    required int index,
  }) {
    return GNav(
      tabs: const [
        GButton(
          icon: Icons.home_filled,
          text: "Home",
        ),
        GButton(
          icon: Icons.directions_car,
          text: "Car",
        ),
        GButton(
          icon: Icons.chat,
          text: "chat",
        )
      ],
      selectedIndex: index,
      gap: 5,
      duration: Duration(milliseconds: 900),
      onTabChange: tabchange,
      iconSize: iconsize,
      tabBorderRadius: 25,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      backgroundColor: backgroundColor,
      tabBackgroundColor: tabgroundColor,
    );
  }
  SliverList? raceuser(){
     final provider=Provider.of<UpadateRace>(context);
     provider.update(widget.user.id);
     if(provider.races!=null){
     return SliverList(
      delegate: SliverChildBuilderDelegate(
      childCount:provider.races!.length,
      (ctx,index){
          return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PassagerList(provider.races!.elementAt(index).passenger)));
          },
          child: ListTile(
            title: Text(provider.races!.elementAt(index).originpoint),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.races!.elementAt(index).originpoint),
                Text(provider.races!.elementAt(index).timestart),
              ],
            ),
            trailing: IconButton(
              onPressed: ()async{
                final response=await APIservicesRace.deleterace(provider.races!.elementAt(index).id);
                if (response==0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passageiro deletado")));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tente Novamente")));
                }
                provider.update(widget.user.id);
              },icon: Icon(Icons.delete),
            ),
          ),
        );
      })
      );
     }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final mquery = MediaQuery.of(context);
    final msgnofound = Center(child: mgsnogetall("Nao encontrado corridas"));
    final race=raceuser();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildappbar(context,
            heightbar: 0.2,
            radiuscircle: 0.05,
            heightsizebox: 0.01,
            color: Colors.black12,
            tab: __tabappbar(Color(0xFF695E19), 5)
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Race>?>(
                future: widget.listrace,
                builder: (context, list) {
                  if (list.hasData) {
                    return ListView.builder(
                        itemCount: list.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: ()async{
                                if (list.hasData) {
                                  int? response=await aceptrace(list.data!.elementAt(index).id);
                                  if(response==0){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passageiro aceito")));
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Desculpe, não foi possível associá-lo a esta corrida.")));
                                  }
                                }
                              },
                              child: Container(
                                height: 100,
                                child: ListTile(
                                  title: Text(
                                      list.data!.elementAt(index).originpoint),
                                  subtitle: Text(
                                      list.data!.elementAt(index).endpoint),
                                  trailing: Text(
                                      list.data!.elementAt(index).timestart),
                                ),
                              ));
                        });
                  }
                  return msgnofound;
                }),
            Padding(
                padding: EdgeInsets.all(32),
                child: offerride(
                    height: 10,
                    controller1: controller1,
                    controller2: controller2,
                    controller3: controller3)),
            (race!=null)?CustomScrollView(slivers: [
              race
            ],):msgnofound
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
                            user: widget.user,
                           gnav: _build_gnav(
                                backgroundColor: Color.fromARGB(3, 0, 0, 0),
                                tabgroundColor: Colors.white12,
                                tabchange: (index) {
                                  if (index == 0) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RacePage(widget.user)));
                                  }
                                },
                                iconsize: 20,
                                index: 1),
                          )));
                }
              }),
        ),
      ),
    );
  }
}
