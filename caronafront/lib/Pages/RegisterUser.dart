import 'dart:io';

import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/model/Provider/UpdateProviderText.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterUser> {
  final key = GlobalKey<FormState>();
  TextEditingController textname = TextEditingController();
  TextEditingController textra = TextEditingController();
  TextEditingController textemail = TextEditingController();
  TextEditingController textemailconfirm = TextEditingController();
  TextEditingController textesenha = TextEditingController();
  TextEditingController textsenhaconfirm = TextEditingController();
  void navigator(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>AuthUser()));
  }
  void sendcreatebackcreateruser(User user,String confirmemail,
      String confirmsenha, GlobalKey<FormState> key) async {
        bool value=key.currentState!.validate();
        if (value) {
          int reponse=await APIservicosUser.createuser(user,user.ra,confirmemail,confirmsenha);
          if (reponse==-1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("usuário foi criado com sucesso!")));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("O usuário não pode ser cadastrado.")));
          }
        }
      }
  String? validatoremail(String? value) {
    return "Teste";
  }

  String? validatorpassword(String? value) {
    return "Teste";
  }

  String? validatera(String? value) {
    return "Teste";
  }

  @override
  Widget build(BuildContext context) {
    final textbutton = TextButton(
        onPressed: () {
          navigator(context);
        },
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.transparent;
            },
          ),
        ),
        child: Text(
          "Login?",
          style: TextStyle(decoration: TextDecoration.underline),
        ));
    return Scaffold(
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Name",
                    controller: textemail,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Ra",
                    controller: textra,
                    validate: validatera,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "E-mail",
                    controller: textemailconfirm,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "E-mail Confirmar",
                    controller: textemailconfirm,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                      validate: validatorpassword,
                      legend: "Senha",
                      controller: textesenha),
                  TextFormFieldAuthRegister(
                      validate: validatorpassword,
                      legend: "Senha confirmar",
                      controller: textsenhaconfirm),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => sendcreatebackcreateruser(
                        User("", textname.text,textemail.text ,textesenha.text,false,textra.text,
                        createdAt: null, updateAt: null),
                        textemailconfirm.text,
                        textsenhaconfirm.text,key),
                    child: ButtonBarNew(
                      height: 50,
                      fontsize: 16,
                      color: Colors.yellow,
                      title: "Cadastrar",
                    ),
                  ),SizedBox(height: 20,),
                  textbutton
                ],
              ))),
    );
  }
}
