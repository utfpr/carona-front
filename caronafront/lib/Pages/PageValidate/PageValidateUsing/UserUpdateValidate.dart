import 'package:caronafront/Pages/PageValidate/Racevalidadate.dart';
import 'package:caronafront/Pages/UserPages/EditUser.dart';
import 'package:caronafront/Pages/UserPages/Profile.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class UserUpdateValidate extends StatelessWidget {
  UserUpdateValidate(
      {super.key,
      required this.user,
      required this.name,
      required this.email,
      required this.password,
      required this.actualpassword,
      required this.newpassword});
  User user;
  String name;
  String email;
  String password;
  String actualpassword;
  String newpassword;
  sendupdateuserdataback(String newname, String newemail, String actualpassword,
      String newpassword, String confirmpassword, BuildContext ctx) async {
    int response = await APIservicosUser.updateuser(user.id, newname, newemail,
        actualpassword, newpassword, confirmpassword);
    if (response == 0) {
      user.email = newemail;
      user.name = newname;
      user.password = newpassword;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text("Dados Atualizados !")));
      // ignore: use_build_context_synchronously
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => Profile(user: user)));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (context) => EditUser(user: user)));
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text(" Tente novamente!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Racevalidate(
        user: user,
        tile1: Textinfo(
          info: name,
          legend: "nome",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile2: Textinfo(
          info: email,
          legend: "E-mail",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile3: Textinfo(
          info: actualpassword,
          legend: "Senha atual",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile4: Textinfo(
          info: newpassword,
          legend: "nova Senha",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        tile5: const Textinfo(
          info: "",
          legend: "",
          fontsizeinfo: 14,
          fontsizelegend: 16,
        ),
        back: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx1) => EditUser(user: user))),
        funct: () => sendupdateuserdataback(
            name, email, actualpassword, newpassword, newpassword, context),
        buttom: ButtonBarNew(
            color: Colors.yellow,
            title: "Atualizar",
            height: 50,
            fontsize: 16));
  }
}
