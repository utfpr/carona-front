import 'package:caronafront/Pages/PageValidate/Uservalidadate.dart';
import 'package:caronafront/Pages/UserPages/RegisterUser.dart';
import 'package:caronafront/Pages/UserPages/UserCodeValidate.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class UserRegisterValidate extends StatelessWidget {
  
  UserRegisterValidate({super.key,required this.user,
  required this.confirmemail,required this.confirmsenha});

  User user;
  String confirmemail;
  String confirmsenha;
  void back(BuildContext context, User user) {
    // volta para alterar os dados antes do cadastros
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context1) => RegisterUser(user: user)));
  }

  void createuser(
      BuildContext context,
      String name,
      String email,
      String password,
      String ra,
      String confirmemail,
      String confirpassword) async {
    // envia os dados para o back para criar o usuário
    int response = await APIservicosUser.createuser(name, email, password, ra,
        confirmemail, confirpassword); // envia dos dados para back-end
    if (response == 0) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context1) => Codepage(
              email:
                  email))); // caso o usuario seja cadastro vai para tela de validação do codigo
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context1) => RegisterUser(
              user: null))); // volta para tela de registro do usuário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Uservalidate(
        back: () => back(context, user), // volta para tela de registro do usuario
        user: user,
        tile1: Textinfo(
          info: user.name,
          legend: "nome",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile2: Textinfo(
          info: user.email,
          legend: "E-mail",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile3: Textinfo(
          info: user.password,
          legend: "Senha",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile4: Textinfo(
          info: user.ra,
          legend: "RA",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        funct: () => createuser(context, user.name, user.email, user.password,
            user.ra, confirmemail, confirmsenha),
        buttom: ButtonBarNew(
            color: Colors.yellow,
            title: "Criar Conta",
            height: 50,
            fontsize: 16));
  }
}
