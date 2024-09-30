// ignore_for_file: non_constant_identifier_names

import 'package:caronafront/Pages/RacePages/Racepage.dart';
import 'package:caronafront/Pages/UserPages/RegisterUser.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Buttons/TextButton.dart';
import 'package:caronafront/Pages/widget/Images/ImageCustom.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegisterPassword.dart';
import 'package:caronafront/Provider/UpdateProviderText.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({super.key});

  @override
  State<AuthUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AuthUser> {
  TextEditingController senha_text = TextEditingController();
  TextEditingController ra_email = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  FocusNode focus=FocusNode();
  void navigator(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterUser(
                  user: null,
                )));
  }

  void authemail(String email, String senha, GlobalKey<FormState> key) async {
    User? response = await APIservicosUser.auth(email, senha);
    if (key.currentState!.validate() && response != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage(response)));
      ra_email.clear();
      senha_text.clear();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Tente Novamente")));
    }
  }

  void authra(String ra, String senha, GlobalKey<FormState> key) async {
    User? response = await APIservicosUser.authra(ra, senha);
    if (response != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage(response)));
      ra_email.clear();
      senha_text.clear();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Tente Novamente")));
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
  Widget build(BuildContext acontext) {
    final provider = Provider.of<UpdateProviderText>(context);
    final query = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Imagecustom(
                    imageurl: "assets/Images/logoapp.png",
                    horizontal: 0,
                    vertical: 0,
                    width: 0.25 * query.width,
                    height: 0.25 * query.height,
                  ),
                  TextFormFieldAuthRegister(
                    tipo: TextInputType.emailAddress,
                    validate: validatera,
                    legend: provider.campovalidate,
                    controller: ra_email,
                    space: query.height * 0.02,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 0,
                      space: query.height * 0.02,
                      tipo: TextInputType.name,
                      validate: validatorpassword,
                      legend: "Senha",
                      controller: senha_text),
                  GestureDetector(
                    onTap: () => authra(ra_email.text, senha_text.text, key),
                    child: ButtonBarNew(
                        color: Colors.yellow,
                        title: "LOGIN",
                        height: 50,
                        fontsize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextLinkerButton(text: "Seja bem-vindo! Cadastre-se", 
                  onPressed: ()=>navigator(context)),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )));
  }
}
