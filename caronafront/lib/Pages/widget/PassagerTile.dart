import 'package:caronafront/model/PassagerModel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class PassgerTitle extends StatefulWidget {
  PassgerTitle(this.passager,{super.key});
  Passager passager;
  @override
  State<PassgerTitle> createState() => _PassgerTitleState();
}

class _PassgerTitleState extends State<PassgerTitle> {
  late User user;
  @override
  Widget build(BuildContext context) {
    void getuser()async{
      final userdata=await APIservicosUser.fectchuser(widget.passager.userId);
      if (userdata!=null) {
        setState(() {
        user=userdata;
      });
      }
    }
  getuser();
  return ListTile(
            title: Text(user.name),
            subtitle:Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user.email)
              ],
            ),
    );
  }
}