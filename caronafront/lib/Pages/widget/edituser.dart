

import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  EditUser(
      {required this.user,
      super.key});
  final User user;
  String? validatename(String? name) {
    if (name!.isEmpty) {
      return "Campo Vazio";
    }
    return null;
  }

  String? validateemail(String? email) {
    if (!email!.contains("@")) {
      return "O campo deve conter @";
    }
    return null;
  }
  sendupdateuserdataback(String newname,String newemail,BuildContext ctx)async{
    int response=await APIservicosUser.updateuser(user.id,newname, newemail, user.password);
    if (response==0) {
      user.email=newemail;
      user.name=newname;
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text("Dados Atualizados !")));
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context)=>Profile(user: user)));
    }else{
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context)=>Profile(user: user)));
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(" Tente novamente!")));
    }
  }
  void updateuser(String name,String email,BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Carvalidate(user: user, 
    tile1: Textinfo(info:name , legend: "nome"), 
    tile2: Textinfo(info: email, legend: "E-mail"),
    back:()=>Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1)=>EditUser(user: user))), 
    funct: ()=>sendupdateuserdataback(name, email, ctx), 
    buttom: ButtonBarNew(color: Colors.yellow, 
    title: "Atualizar", height: 50, fontsize: 16))));
  }
  void back(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Profile(user: user)));
  }
  @override
  Widget build(BuildContext context) {
  TextEditingController textname = TextEditingController(text:user.name);
  TextEditingController textemail = TextEditingController(text: user.email);
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        back(context);
      }, icon: Icon(Icons.arrow_back_ios)),),
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: [
                  TextFormFieldAuthRegister(
                      obscure: false,
                      tipo: TextInputType.name,
                      validate: validatename,
                      legend: "Nome",
                      controller: textname),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                      obscure: false,
                      tipo: TextInputType.emailAddress,
                      validate:validateemail ,
                      legend: "E-mail",
                      controller: textemail),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        updateuser(textname.text,textemail.text,context);
                      }
                    },
                    child: ButtonBarNew(
                        color: Colors.yellow,
                        title: "Alterar Dados",
                        height: 50,
                        fontsize: 16),
                  )
                ],
              ))),
    );
  }
}
