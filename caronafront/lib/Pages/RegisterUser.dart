import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/Uservalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegisterPassword.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RegisterUser extends StatefulWidget {
  RegisterUser({required this.user, super.key});
  User? user;
  @override
  State<RegisterUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterUser> {
  final key = GlobalKey<FormState>();
  void navigator(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void back(BuildContext context, User user) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => RegisterUser(user: user)));
  }

  void createuser(
      BuildContext context,
      String name,
      String email,
      String password,
      String ra,
      String confirmemail,
      String confirpassword) async {
    int response = await APIservicosUser.createuser(
        User(-1, name, email, password, false, ra,),
        ra,
        confirmemail,
        confirpassword);
    if (response == 0) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => RegisterUser(user: null)));
    }
  }

  void sendcreatebackcreateruser(
      BuildContext context,
      User user,
      String confirmemail,
      String confirmsenha,
      GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => Uservalidate(
              back: () => back(ctx, user),
              user: user,
              tile1: Textinfo(info: user.name, legend: "nome",fontsizeinfo: 14,fontsizelegend: 16,),
              tile2: Textinfo(info: user.email, legend: "E-mail",fontsizeinfo: 14,fontsizelegend: 16,),
              tile3: Textinfo(info: user.password, legend: "Senha",fontsizeinfo: 14,fontsizelegend: 16,),
              tile4: Textinfo(info: user.ra, legend: "RA",fontsizeinfo: 14,fontsizelegend: 16,),
              funct: () => createuser(ctx, user.name, user.email, user.password,
                  user.ra, confirmemail, confirmsenha),
              buttom: ButtonBarNew(
                  color: Colors.yellow,
                  title: "Criar Conta",
                  height: 50,
                  fontsize: 16))));
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
    TextEditingController textname = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.name);
    TextEditingController textra = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.ra);
    TextEditingController textemail = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.email);
    TextEditingController textemailconfirm = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.email);
    TextEditingController textesenha = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.password);
    TextEditingController textsenhaconfirm = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.password);
    final textbutton = TextButton(
        onPressed: () => navigator(context),
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
                    legend: "Name",
                    tipo: TextInputType.name,
                    controller: textname,
                    validate: validatera,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Ra",
                    controller: textra,
                    tipo: TextInputType.name,
                    validate: validatera,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "E-mail",
                    tipo: TextInputType.emailAddress,
                    controller: textemail,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Confirmar E-mail",
                    tipo: TextInputType.emailAddress,
                    controller: textemailconfirm,
                    validate: validatoremail,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 1,
                      tipo: TextInputType.name,
                      validate: validatorpassword,
                      legend: "Senha",
                      controller: textesenha),
                    TextFormFieldAuthRegisterPassword(
                        number: 2,
                        tipo: TextInputType.visiblePassword,
                        validate: validatorpassword,
                        legend: "Confirmar senha ",
                        controller: textsenhaconfirm),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => sendcreatebackcreateruser(
                        context,
                        User(-1, textname.text, textemail.text, textesenha.text,
                            false, textra.text,),
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
