import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  EditUser({required this.presized,required this.drawer, super.key});
  final Widget drawer;
  final PreferredSizeWidget presized;
  TextEditingController textname=TextEditingController();
  TextEditingController textemail=TextEditingController();
  String? validatename(String? name){
    if (name!.isEmpty) {
      return "Campo Vazio";
    }
    return null;
  }
  String? validateemail(String? email){
    if (email!.contains("@")) {
      return "O campo deve conter @";
    }
    return null;
  }
  updateuser(){

  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>key=GlobalKey<FormState>();
    return Scaffold(
      drawer: drawer,
      appBar: presized,
      body: Form(
        key: key,
          child: ListView(
        children: [
          TextFormFieldAuthRegister(obscure: false, 
          tipo: TextInputType.name, 
          validate:validatename, 
          legend: "Nome", controller: textname),
          TextFormFieldAuthRegister(obscure: false, 
          tipo: TextInputType.name, 
          validate:validateemail, 
          legend: "E-mail", controller: textemail),
          GestureDetector(
            onTap:(){
              if (key.currentState!.validate()) {
                
              }
            } ,
            child: ButtonBarNew(color: Colors.yellow, 
            title: "Alterar Dados", height: 50, fontsize: 16),
          )
        ],
      )),
    );
  }
}
