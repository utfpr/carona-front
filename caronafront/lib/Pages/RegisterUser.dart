import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

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
  void navigator(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void sendcreatebackcreateruser(User user, String confirmemail,
      String confirmsenha, GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      int reponse = await APIservicosUser.createuser(
          user, user.ra, confirmemail, confirmsenha);
      if (reponse == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("usuário foi criado com sucesso!")));
        textemail.clear();
        textemailconfirm.clear();
        textesenha.clear();
        textsenhaconfirm.clear();
        textra.clear();
        textname.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("O usuário não pode ser cadastrado.")));
      }
    }
  }

  String? validatoremail(String? value) {
    if (!value!.contains("@")) {
      return "Falta o Caracter @";
    }
    return null;
  }

  String? validatorpassword(String? value) {
    if (value!.length < 8) {
      return """mínimo 1 caractere especial, 8 caracteres,
       1 letra minúscula e 1 letra maiúscula""";
    }
    return null;
  }

  String? validatera(String? value) {
    if (value!.isEmpty) {
      return "Campo vazio";
    }
    return null;
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
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextFormFieldAuthRegister(
                    obscure: false,
                    legend: "Name",
                    tipo: TextInputType.name,
                    controller: textname,
                    validate: validatera,
                  ),
                  TextFormFieldAuthRegister(
                    obscure: false,
                    legend: "Ra",
                    controller: textra,
                    tipo: TextInputType.name,
                    validate: validatera,
                  ),
                  TextFormFieldAuthRegister(
                    obscure: false,
                    legend: "E-mail",
                    tipo: TextInputType.emailAddress,
                    controller: textemail,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                    obscure: false,
                    legend: "E-mail Confirmar",
                    tipo: TextInputType.emailAddress,
                    controller: textemailconfirm,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                      obscure: true,
                      tipo: TextInputType.name,
                      validate: validatorpassword,
                      legend: "Senha",
                      controller: textesenha),
                  TextFormFieldAuthRegister(
                      obscure: true,
                      tipo: TextInputType.visiblePassword,
                      validate: validatorpassword,
                      legend: "Senha confirmar",
                      controller: textsenhaconfirm),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => sendcreatebackcreateruser(
                        User("", textname.text, textemail.text, textesenha.text,
                            false, textra.text,
                            createdAt: null, updateAt: null),
                        textemailconfirm.text,
                        textsenhaconfirm.text,
                        key),
                    child: ButtonBarNew(
                      height: 50,
                      fontsize: 16,
                      color: Colors.yellow,
                      title: "Cadastrar",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textbutton
                ],
              ))),
    );
  }
}
