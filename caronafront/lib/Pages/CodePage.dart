import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Codepage extends StatelessWidget {
  Codepage({super.key, required this.user});
  String user;
  TextEditingController text = TextEditingController();
  String? validate(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
  String information="código de verificação foi enviado para "+ user;
    final query=MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(padding: EdgeInsets.fromLTRB(query.width*0.1,query.height*0.26,query.width*0.1,query.height*0.13) ,
      child: Column(
        children: [
          Text(information,style: TextStyle(fontSize: 16,color: Colors.white),),
          SizedBox(height: 40,),
          TextFormFieldTile(
              leght: 6,
              legend: "Codigo de Validação",
              hint: "Ex: 918975",
              controller: text,type: TextInputType.number,
              value: validate),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: ButtonBarNew(
                color: Colors.yellow,
                title: "Validar Codigo",
                height: 50,
                fontsize: 16),
          )
        ],
      ),)
    );
  }
}
