

import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class RacePage extends StatefulWidget {
  const RacePage(this.user,this.pages,this.races,{super.key});
  final User user;
  final List<Race> races;
  final void Function() pages; 
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  final search=TextEditingController();
  List<Widget> pages=[];
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    search.dispose();
  }
  
  AppBar _buildappbar(BuildContext context,User user,
  {required double heightbar,required Color color, 
  required double radiuscircle,required double heightsizebox, required TabBar tab}){
    return AppBar(
    bottom: tab ,
    actions: [
      Padding(padding:const EdgeInsetsDirectional.all(15) ,
      child:CircleAvatar(radius: radiuscircle*MediaQuery.of(context).size.height,backgroundColor:Color.fromARGB(221, 51, 39, 153) ,),)],
    toolbarHeight: heightbar*MediaQuery.of(context).size.height,
    backgroundColor: color,
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisSize: MainAxisSize.min
      ,children: [
      Text("Olá, Guilherme"),
      Text("Caronas rápido e fácil")
    ]),);
  }
  TabBar __tabappbar(Color box_color,double indicator_weight){
    return  TabBar(
    indicatorColor: box_color,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorWeight: indicator_weight,
    tabs: const [
      Tab(icon:Center(child:Text("Procurar",
      style: TextStyle(color: Colors.white,fontSize: 15),
      )),
      ),
      Tab(icon:Center(child:Text("Oferecer",
      style: TextStyle(color: Colors.white,fontSize: 15),)),
      )]);
  }
  Padding _buildsearchappbar(){
    return Padding(
        padding:EdgeInsets.all(16.0),
        child:Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(180)
        ),
        child: TextFormField(
          showCursor: false,
          decoration: const InputDecoration(
            border: InputBorder.none,
            iconColor: Colors.white,
            icon: Padding(padding: EdgeInsets.all(9.0),
            child:Icon(Icons.search) ,),
            contentPadding: EdgeInsets.all(16.0)
          ),
          controller:search,
        ),
      )
    );
  }
  GNav _build_gnav({required Color backgroundColor,
  required Color tabgroundColor,required void Function(int) tabchange, 
  required double iconsize}){
    return GNav(
      tabs: const [
      GButton(icon: Icons.home_filled,text: "Home",),
      GButton(icon: Icons.chat_rounded,text:"chat",),
      GButton(icon: Icons.person_2_outlined,text:"profile",)
    ], 
      gap: 8,
      duration: Duration(milliseconds: 900),
      onTabChange:tabchange ,
      iconSize: iconsize,
      tabBorderRadius: 25,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      backgroundColor: backgroundColor,
      tabBackgroundColor: tabgroundColor,     
    );
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
    length: 2, 
    child:Scaffold(
    appBar: _buildappbar(context,widget.user,heightbar: 0.2,
    radiuscircle: 0.05,heightsizebox: 0.01,color: Colors.black12,tab:__tabappbar(Colors.yellowAccent,5) 
    ,),body: TabBarView(children: [
      Column(children: [
        _buildsearchappbar(),
        CustomScrollView(slivers: [SliverList(delegate:
        SliverChildBuilderDelegate(
          (contex,index){}
          ))],)
      ],)     
    ]),
    bottomNavigationBar:Padding(padding:const 
    EdgeInsets.symmetric(vertical: 16, 
    horizontal: 16,),child: _build_gnav(backgroundColor:const Color.fromARGB(3, 0, 0, 0), 
    tabgroundColor: Colors.grey,iconsize: 20,
    tabchange: (index){}),),
    ),
    
  );
  }
}