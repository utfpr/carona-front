import 'package:caronafront/Pages/PageValidate/PageValidateUsing/UserUpdateValidate.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/Images/ImageCustom.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegisterPassword.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class EditUser extends StatelessWidget {
  const EditUser({required this.user, super.key});
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

  void updateuser(
      String name,
      String email,
      String newpassword,
      String actualpassword,
      String confirmpassword,
      BuildContext context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => UserUpdateValidate(
            user: user,
            name: name,
            email: email,
            password: newpassword,
            actualpassword: actualpassword,
            newpassword: newpassword)));
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
    final query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => back(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(32),
              child: ListView(
                children: [
                  Imagecustom(
                    imageurl: "assets/Images/logoapp.png",
                    horizontal: 0,
                    vertical: 0,
                    width: 0.25 * query.width,
                    height: 0.25 * query.height,
                  ),
                  TextFormFieldAuthRegister(
                      tipo: TextInputType.name,
                      validate: validatename,
                      legend: "Nome",
                      controller: textname,
                      space: query.height * 0.02),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                      tipo: TextInputType.emailAddress,
                      validate: validateemail,
                      legend: "E-mail",
                      controller: textemail,
                      space: query.height * 0.02),
                  DropDownTile<String>(
                      value: "@alunos.utfpr.edu.br",
                      legend: "Dominio",
                      list: const [
                        DropdownMenuItem(
                          value: "@alunos.utfpr.edu.br",
                          child: Text("@alunos.utfpr.edu.br"),
                        ),
                        DropdownMenuItem(
                          value: "@utfpr.edu.br",
                          child: Text("@utfpr.edu.br"),
                        )
                      ],
                      onChanged: (value) {
                        if (value == "@alunos.utfpr.edu.br") {
                        } else {}
                      }),
                  TextFormFieldAuthRegisterPassword(
                    number: 3,
                    tipo: TextInputType.text,
                    validate: validatepassword,
                    legend: "Senha atual",
                    controller: textpasswordeging,
                    space: query.height * 0.02,
                  ),
                  TextFormFieldAuthRegisterPassword(
                    number: 4,
                    tipo: TextInputType.text,
                    validate: validatepassword,
                    legend: "nova Senha",
                    controller: textpasswordnew,
                    space: query.height * 0.02,
                  ),
                  TextFormFieldAuthRegisterPassword(
                    number: 5,
                    tipo: TextInputType.text,
                    validate: validatepassword,
                    legend: "Confirmar senha nova",
                    controller: textpasswordnewconfirm,
                    space: query.height * 0.02,
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
