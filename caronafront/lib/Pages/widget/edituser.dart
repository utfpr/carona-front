import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  EditUser(
      {required this.user,
      required this.drawer,
      super.key});
  final Widget drawer;
  final User user;
  TextEditingController textname = TextEditingController();
  TextEditingController textemail = TextEditingController();
  String? validatename(String? name) {
    if (name!.isEmpty) {
      return "Campo Vazio";
    }
    return null;
  }

  String? validateemail(String? email) {
    if (email!.contains("@")) {
      return "O campo deve conter @";
    }
    return null;
  }

  void updateuser() async {
    
  }
  void back(BuildContext context){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Profile(user: user)));
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      endDrawer: drawer,
      appBar: AppBar(leading: IconButton(onPressed: (){
        back(context);
      }, icon: Icon(Icons.arrow_back_ios)),),
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(16),
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
                      tipo: TextInputType.name,
                      validate: validateemail,
                      legend: "E-mail",
                      controller: textemail),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        updateuser();
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
