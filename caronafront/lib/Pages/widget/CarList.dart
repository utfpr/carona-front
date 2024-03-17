import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CarList extends StatefulWidget {
  final GNav gNav;
  const CarList({super.key, required this.gNav});
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  Column mgsnogetall(String msg){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(msg,style: TextStyle(
          color: Colors.white.withOpacity(0.1),
          fontSize: 12
        ),),
        SizedBox(
          child: Icon(Icons.car_crash,size: 100,
          color:Colors.white.withOpacity(0.1),),
          width: 100,
          height: 100,
        )
      ],
    );
  }
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
    final msgnotfoundcar=Center(child: mgsnogetall("Nao encontrado carros"),);
    return Scaffold(
    appBar:buildappbar(context,heightbar: 0.2,
    radiuscircle: 0.05,heightsizebox: 0.01,
    color: Colors.black12,
    ),
    body:msgnotfoundcar ,
    floatingActionButton:FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180)
      ),
      backgroundColor: Colors.yellow,
      hoverColor: Colors.yellow,
      onPressed:(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarRegisterPage()));
    },
    child: Icon(Icons.add),
    ),
    bottomNavigationBar:widget.gNav ,
    );
  }
}