import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class CarTitle extends StatefulWidget {
  CarTitle({required this.car,super.key});
  Car? car;
  @override
  State<CarTitle> createState() => _CarTitleState();
}

class _CarTitleState extends State<CarTitle> {

  Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: const Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
  }

  Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: const Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          Text(
            " Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Dismissible(key: Key(widget.car!.plate),
      background:slideLeftBackground(),
      secondaryBackground: slideRightBackground(),
      onDismissed: (derection)async{
        if (derection==DismissDirection.endToStart) {
          int del=await APIservicosCar.deletecar(widget.car!.id);
          print(del);
          if (del==0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content:Text("deletado carro") )
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Nao foi possivel deletar essse carro"))
            );
          }
        } 
      },
      child: ListTile(
        leading: CircleAvatar(),
        subtitle: Text(widget.car!.description
        ,style:TextStyle(
          fontSize: 12,
          color: Colors.white.withOpacity(0.5)
        ),),
        title:Text(widget.car!.plate,
        style:const TextStyle(
          fontSize:15 ,
          color: Colors.white
        ),),

      )
    );
  }
}