import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/CarHomePage.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/Racevalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegisterPassword.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  EditUser({required this.user, super.key});
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

  sendupdateuserdataback(String newname, String newemail, String actualpassword,
      String newpassword, String confirmpassword, BuildContext ctx) async {
    int response = await APIservicosUser.updateuser(user.id, newname, newemail,
        actualpassword, newpassword, confirmpassword);
    if (response == 0) {
      user.email = newemail;
      user.name = newname;
      user.password=newpassword;
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text("Dados Atualizados !")));
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => Profile(user: user)));
    } else {
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => EditUser(user: user)));
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(" Tente novamente!")));
    }
  }

  void updateuser(
      String name,
      String email,
      String newpassword,
      String actualPassword,
      String confirmpassword,
      BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Racevalidate(
            user: user,
            tile1: Textinfo(info: name, legend: "nome",fontsizeinfo: 14,fontsizelegend: 16,),
            tile2: Textinfo(info: email, legend: "E-mail",fontsizeinfo: 14,fontsizelegend: 16,),
            tile3: Textinfo(info: actualPassword,legend: "Senha atual",fontsizeinfo: 14,fontsizelegend: 16,),
            tile4: Textinfo(info: newpassword, legend: "nova Senha",fontsizeinfo: 14,fontsizelegend: 16,),
            tile5: Textinfo(info: "", legend: "",fontsizeinfo: 14,fontsizelegend: 16,),
            back: () => Navigator.of(ctx).pushReplacement(
                MaterialPageRoute(builder: (ctx1) => EditUser(user: user))),
            funct: () => sendupdateuserdataback(
                name, email, actualPassword, newpassword, confirmpassword, ctx),
            buttom: ButtonBarNew(
                color: Colors.yellow,
                title: "Atualizar",
                height: 50,
                fontsize: 16))));
  }

  void back(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Profile(user: user)));
  }

  String? validatepassword(String? value) {}
  @override
  Widget build(BuildContext context) {
    TextEditingController textname = TextEditingController(text: user.name);
    TextEditingController textemail = TextEditingController(text: user.email);
    TextEditingController textpasswordeging = TextEditingController();
    TextEditingController textpasswordnew = TextEditingController();
    TextEditingController textpasswordnewconfirm = TextEditingController();
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              back(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: [
                  TextFormFieldAuthRegister(
                      tipo: TextInputType.name,
                      validate: validatename,
                      legend: "Nome",
                      controller: textname),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                      tipo: TextInputType.emailAddress,
                      validate: validateemail,
                      legend: "E-mail",
                      controller: textemail),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 3,
                      tipo: TextInputType.text,
                      validate: validatepassword,
                      legend: "Senha atual",
                      controller: textpasswordeging),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 4,
                      tipo: TextInputType.text,
                      validate: validatepassword,
                      legend: "nova Senha",
                      controller: textpasswordnew),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 5,
                      tipo: TextInputType.text,
                      validate: validatepassword,
                      legend: "Confirmar senha nova",
                      controller: textpasswordnewconfirm),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        updateuser(
                            textname.text,
                            textemail.text,
                            textpasswordnew.text,
                            textpasswordeging.text,
                            textpasswordnewconfirm.text,
                            context);
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
