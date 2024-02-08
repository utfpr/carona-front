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
  AppBar _buildappbar(BuildContext context,User user,
  {required Color color,required double heightbar, 
  required double radiuscircle,required double heightsizebox}){
    return AppBar(
    actions: [CircleAvatar(radius: radiuscircle*MediaQuery.of(context).size.height,)],
    toolbarHeight: heightbar*MediaQuery.of(context).size.height,
    backgroundColor:color ,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly 
      ,children: [
      Text("Olá,${user.name}"),
      Text(" Caronas rápido e fácil")
    ]),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: _buildappbar(context,widget.user,heightbar: 0.2,
    radiuscircle: 0.06,heightsizebox: 0.01,color: Colors.deepPurple),
    body: CustomScrollView(slivers: [
        SliverAppBar(
          
        )
      ],)
    );
  }
}