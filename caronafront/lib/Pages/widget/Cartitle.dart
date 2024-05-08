import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CarTitle extends StatelessWidget {
  const CarTitle({required this.user,required this.car, super.key});
  final Car car;
  final User user;
  void remover() {

  }
  void update(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CarRegisterPage(car: car,user:user,butt:"Atualizar carro")));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            height:50,
            child: ListTile(
            tileColor: Color(0xFF0E0B13),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed:remover ,icon: Icon(
                  Icons.delete_outlined,
                  size: 18,
                ),),
                IconButton(onPressed:()=>update(context) ,icon: Icon(
                  Icons.edit_outlined,
                  size: 18,
                ),),
              ],
            ),
            contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
            title: Text(
              "placa do carro",
              style: TextStyle(color: Colors.white.withOpacity(0.2),fontSize: 14),
            ),
            subtitle: Text(car.plate,style: TextStyle(fontSize: 16),),
          ),
          ),
          Container(
            height: 70,
            child:ListTile(
            contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
            tileColor: Color(0xFF0E0B13),
            title: Text(
              "descrição (modelo, cor etc.)",
              style: TextStyle(color: Colors.white.withOpacity(0.2),fontSize: 14),
            ),
            subtitle: Text(car.description,style: TextStyle(fontSize: 16),),))
        ],
      );
  }
}
