import 'package:caronafront/Pages/PageValidate/PageValidateUsing/UserRegisterValidate.dart';
import 'package:caronafront/Pages/UserPages/AuthUser.dart';
import 'package:caronafront/Pages/UserPages/UserPolitcPage.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Check/CheckBoxLinker.dart';
import 'package:caronafront/Pages/widget/DropdownNew.dart';
import 'package:caronafront/Pages/widget/Images/ImageCustom.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegister.dart';
import 'package:caronafront/Pages/widget/Text/TextformFieldAuthRegisterPassword.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
// Tela de cadastro do usuário
class RegisterUser extends StatefulWidget {
  RegisterUser({required this.user, super.key});
  User? user;
  bool? value =
      false; // o checkbox começa como desmarcado , e o usuário aceitar a politcas do app
  late TextEditingController textname;
  late TextEditingController textra;
  late TextEditingController textemail;
  late TextEditingController textemailconfirm;
  late TextEditingController textesenha;
  late TextEditingController textsenhaconfirm;
    String domain="@alunos.utfpr.edu.br";
  @override
  State<RegisterUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterUser> {
  final key = GlobalKey<FormState>(); // chave de validação
  @override
  void initState() {
    // caso o usuário volte para alterar os dados a informação dos campos mantem
    super.initState();
    widget.textname = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.name);
    widget.textra = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.ra);
    widget.textemail = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.email);
    widget.textemailconfirm = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.email);
    widget.textesenha = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.password);
    widget.textsenhaconfirm = (widget.user == null)
        ? TextEditingController()
        : TextEditingController(text: widget.user!.password);
  }

  void navigator(BuildContext context) {
    // volta para a autenticação do usuário
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
  }

  void apppolitic(BuildContext contentx) {
    // vai para tela das politcas do app
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => PoliticaPage(
              user: User(-1, widget.textname.text, widget.textemail.text,
                  widget.textesenha.text, false, widget.textra.text),
            )));
  }

  SnackBar snackBar(
      String snack, double fontsize, Color groud, Color textcolor) {
    return SnackBar(
      content:
          Text(snack, style: TextStyle(fontSize: fontsize, color: textcolor)),
      backgroundColor: groud,
    );
  }

  void sendcreatebackcreateruser(
      BuildContext context,
      User user,
      String confirmemail,
      String confirmsenha,
      GlobalKey<FormState> key) async {
    if (key.currentState!.validate() && widget.value!) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => UserRegisterValidate(
                confirmemail: confirmemail,
                confirmsenha: confirmsenha,
                user: user,
              )));
    } else if (widget.value == false) {
      // mostra um snack bar, avisando que a politca do app não foi aceita
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          "A politica de termos do aplicativo não foi aceita",
          14,
          Colors.black12,
          Colors.white));
    }
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
    final query = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => navigator(context),
              icon: Icon(Icons.arrow_back_ios))),
      body: Form(
          key: key,
          child: Padding(
              padding: EdgeInsets.all(32),
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
                    legend: "Nome",
                    tipo: TextInputType.name,
                    controller: widget.textname,
                    validate: validatera,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Ra",
                    controller: widget.textra,
                    tipo: TextInputType.name,
                    validate: validatera,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "E-mail",
                    tipo: TextInputType.emailAddress,
                    controller: widget.textemail,
                    validate: validatera,
                  ),DropDownTile<String>(
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
                          setState(() {
                            widget.domain=value;
                          });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegister(
                    legend: "Confirmar E-mail",
                    tipo: TextInputType.emailAddress,
                    controller: widget.textemailconfirm,
                    validate: validatera,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 1,
                      tipo: TextInputType.name,
                      validate: validatorpassword,
                      legend: "Senha",
                      controller: widget.textesenha),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormFieldAuthRegisterPassword(
                      number: 2,
                      tipo: TextInputType.visiblePassword,
                      validate: validatorpassword,
                      legend: "Confirmar senha ",
                      controller: widget.textsenhaconfirm),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => sendcreatebackcreateruser(
                        context,
                        User(
                          -1,
                          widget.textname.text,
                          widget.textemail.text+widget.domain,
                          widget.textesenha.text,
                          false,
                          widget.textra.text,
                        ),
                        widget.textemailconfirm.text+widget.domain,
                        widget.textsenhaconfirm.text,
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
                  CheckBoxLinker(
                      text: "Termos de Uso",
                      value: widget.value,
                      onChanged: (value) {
                        setState(() {
                          widget.value = value;
                        });
                      },
                      navigator: () => apppolitic(context))
                ],
              ))),
    );
  }
}
