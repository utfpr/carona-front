import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/servicos/APIservicesRace.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:caronafront/servicos/Dados.dart';
import 'package:flutter/material.dart';

class CarTitle extends StatefulWidget {
  CarTitle({required this.car, super.key});
  Car? car;
  
  late TextEditingController platenew;
  late TextEditingController descriptionew;
  @override
  State<CarTitle> createState() => _CarTitleState();
}

class _CarTitleState extends State<CarTitle> {
  @override
  void initState() {
    super.initState();
    widget.platenew=TextEditingController(text:widget.car!.plate);
    widget.descriptionew=TextEditingController(text: widget.car!.description);
  }

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
    String plate=widget.car!.plate;
    String desscription=widget.car!.description;
    return Dismissible(
        key: Key(plate),
        background: slideLeftBackground(),
        secondaryBackground: slideRightBackground(),
        onDismissed: (derection) async {
          if (derection == DismissDirection.startToEnd) {
            int del = await APIservicosCar.deletecar(widget.car!.id);
            if (del == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("deletado carro")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Nao foi possivel deletar essse carro")));
            }
          }else{

          }
        },
        child: Card(
          child: ExpansionTile(
          children: [
            Column(
              children: [
                Text("Descrição"),
                Text(desscription),
              ],
            ),
          ],
          leading: CircleAvatar(
            child: Icon(Icons.directions_car_filled),
            backgroundColor: Colors.yellow,),
          title: Text(
            plate,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        )),
        );
  }
}
