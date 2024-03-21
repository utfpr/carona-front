import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CarList extends StatefulWidget {

  CarList({super.key, required this.user});
  final User user;
  late Future<List<Car>?>car;
  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    widget.car=APIservicosCar.getallcar(widget.user.id);
  }
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
    body: FutureBuilder<List<Car>?>(
      future: widget.car,
      builder: (ctx,list){
        if (list.hasData) {
          return ListView.builder(
          itemCount: list.data!.length,
          itemBuilder: (ctx,index){
            return CarTitle(car: list.data!.elementAt(index));
          }
          );
        }
        return msgnotfoundcar;
      }
      ),
    floatingActionButton:FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(180)
      ),
      backgroundColor: Colors.yellow,
      hoverColor: Colors.yellow,
      onPressed:(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarRegisterPage(user:widget.user)));
    },
    child: Icon(Icons.add),
    ),
    );
  }
}