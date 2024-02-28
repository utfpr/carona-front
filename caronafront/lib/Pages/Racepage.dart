import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class RacePage extends StatefulWidget {
  const RacePage(this.user,this.pages,{super.key});
  final User user;
  final void Function() pages; 
  @override
  State<RacePage> createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {

  final text=TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    text.dispose();
  }
  AppBar _buildappbar(BuildContext context,User user,
  {required double heightbar,required Color color, 
  required double radiuscircle,required double heightsizebox}){
    return AppBar(
    actions: [
      Padding(padding:EdgeInsetsDirectional.all(15) ,
      child:CircleAvatar(radius: radiuscircle*MediaQuery.of(context).size.height,),)],
    toolbarHeight: heightbar*MediaQuery.of(context).size.height,
    backgroundColor: color,
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly 
      ,children: [
      Text("Olá,"),
      Text(" Caronas rápido e fácil")
    ]),);
  }
  SliverAppBar _buildsliverappbar(Color color,double height,){
    return  SliverAppBar(
      backgroundColor: color,
      toolbarHeight:  height ,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
        Column(
          children: [
            Container(
          color: color,
          height: height-5,
          width: 0.466*MediaQuery.of(context).size.width+1,
          child:Center(child:Text("Procurar"))),
          Container(
          color: Colors.yellowAccent,
          height: 5,
          width: 0.466*MediaQuery.of(context).size.width+1,
          child:Center(child:Text("Procurar"))),
          ],
        ),
        Container(
          color: color,
          height: height,
          width: 0.466*MediaQuery.of(context).size.width,
          child:Center(child:Text("Oferecer")),)
      ])
    );
  }
  SliverToBoxAdapter _buildsearchappbar(){
    return SliverToBoxAdapter(
      child:Padding(
        padding:EdgeInsets.all(16.0),
        child:Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(180)
        ),
        child: TextFormField(
          showCursor: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            iconColor: Colors.white,
            icon: Padding(padding: EdgeInsets.all(9.0),
            child:Icon(Icons.search) ,),
            contentPadding: EdgeInsets.all(16.0)
          ),
          controller:text,
        ),
      ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: _buildappbar(context,widget.user,heightbar: 0.2,
    radiuscircle: 0.05,heightsizebox: 0.01,color: Colors.black12),
    body:CustomScrollView(
        slivers: [
          _buildsliverappbar(Colors.black12,50),
          _buildsearchappbar()
        ],
    )
  );
  }
}