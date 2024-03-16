import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CarList extends StatefulWidget {
  final GNav gNav;
  const CarList({super.key, required this.gNav});
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {

  AppBar buildappbar(BuildContext context,{required double heightbar,required Color color, 
  required double radiuscircle,required double heightsizebox}){
    return AppBar(
    actions: [
      Padding(padding:const EdgeInsetsDirectional.all(15) ,
      child:CircleAvatar(
      radius: radiuscircle*MediaQuery.of(context).size.height,backgroundColor:Color.fromARGB(221, 51, 39, 153) ,),)],
      toolbarHeight: heightbar*MediaQuery.of(context).size.height,
    backgroundColor: color,
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, 
      mainAxisSize: MainAxisSize.min,
      children: [
      Text("Olá,"),
      Text("Caronas rápido e fácil")
    ]),);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:buildappbar(context,heightbar: 0.2,
    radiuscircle: 0.05,heightsizebox: 0.01,
    color: Colors.black12,
    ),
    bottomNavigationBar:widget.gNav ,
    );
  }
}