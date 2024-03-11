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
  bool isSelected=false;
  late FocusNode focusNode; 
  @override
  void initState() {
    super.initState();
    focusNode=FocusNode();
    focusNode.addListener(onFocusChance);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    search.dispose();
  }
  void onFocusChance(){
    if (search.text.isNotEmpty) {
      setState(() {
        isSelected=true;
      });
      return;
    }
    setState(() {
      isSelected=focusNode.hasFocus;
    });
  }
  void request(){
    focusNode.requestFocus();
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
  TextFormField _buildsearchappbar({required TextEditingController controller,required Icon icon,
  required Color iconcolor,required Color fillColor}){
    Column label_text=const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Para onde ?",style: TextStyle(
            fontSize:15, 
            color: Colors.white,
          ),),
          SizedBox(height: 3,),
          Text("Qualquer lugar Qualquer data 1 pessoa",style: TextStyle(
            color: Color.fromARGB(188, 255, 255, 255), fontSize: 10),),
        ]);
    return TextFormField(
    focusNode:focusNode,
    controller: controller,
    showCursor:false,
    decoration: InputDecoration(
      fillColor: fillColor,
      prefixIcon: icon,
      label:isSelected ? null:label_text,
      enabledBorder: const  OutlineInputBorder(borderSide: BorderSide(width: 2.0,color:Colors.white ),borderRadius: BorderRadius.all(Radius.circular(180))),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.white),borderRadius: BorderRadius.all(Radius.circular(180)),
      ),
    ),
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
    radiuscircle: 0.05,heightsizebox: 0.01,
    color: Colors.black12,tab:__tabappbar(Colors.yellow,5) ),
    body: TabBarView(children: [
      Column(children: [
        Padding(
        padding: EdgeInsets.all(16),
        child: GestureDetector(onLongPress: request,child: 
        _buildsearchappbar(controller:search,fillColor: Colors.black12,
        iconcolor: Colors.white,icon: Icon(Icons.search)),)),
    ],)
    ],
),bottomNavigationBar:Padding(padding:const 
    EdgeInsets.symmetric(vertical: 16, 
    horizontal: 16,),child: _build_gnav(backgroundColor:const Color.fromARGB(3, 0, 0, 0), 
    tabgroundColor: Colors.white12,iconsize: 20,
    tabchange: (index){}),),
    )
    );
    
  }
}