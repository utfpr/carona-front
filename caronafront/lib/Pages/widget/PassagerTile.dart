import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIPassenger.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class PassgerTitle extends StatefulWidget {
  PassgerTitle(this.passager,{super.key});
  Passager passager;
  User? user=null;
  @override
  State<PassgerTitle> createState() => _PassgerTitleState();
}

class _PassgerTitleState extends State<PassgerTitle> {
  @override
  Widget build(BuildContext context) {
    void getuser()async{
      final user=await APIservicosUser.fectchuser(widget.passager.userId);
      setState(() {
        widget.user=user;
      });
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
  return Dismissible(
     key: UniqueKey(),
     onDismissed: (derection) async {
      if (derection == DismissDirection.startToEnd){
            int del=await APIPassenger.deletepasseger(widget.passager.userId);
            if (del == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("deletado carro")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Nao foi possivel deletar essse carro")));
            }
          }
     },
     child:ListTile(
            title: Text(widget.user!.name),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.user!.email)
              ],
            ),
            ),
          );
  }
}