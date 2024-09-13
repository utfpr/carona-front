import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextFormField.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Codepage extends StatelessWidget {
  Codepage({super.key, required this.email});
  String email;
  TextEditingController code = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? validate(String? value) {
    if (value!.length < 6) {
      return "Quantidade de caracteres insuficientes";
    }
    return null;
  }

  SnackBar snackBar(
      String snack, double fontsize, Color groud, Color textcolor) {
    return SnackBar(
      content:
          Text(snack, style: TextStyle(fontSize: fontsize, color: textcolor)),
      backgroundColor: groud,
    );
  }

  void validatecode(BuildContext context) async {
    int response = await APIservicosUser.validate(email, int.parse(code.text));
    if (_formkey.currentState!.validate() && response == 0) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthUser()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar(
          "Codigo inválido tente novamente", 14, Colors.black12, Colors.white));
    }
  }

  @override
  Widget build(BuildContext context) {
    String information = "código de verificação foi enviado para " + email;
    final query = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(query.width * 0.1, query.height * 0.26,
                query.width * 0.1, query.height * 0.13),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    information,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormFieldTile(
                      leght: 6,
                      legend: "Codigo de Validação",
                      hint: "Ex: 918975",
                      controller: code,
                      type: TextInputType.number,
                      value: validate),
                 const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => validatecode(context),
                    child: ButtonBarNew(
                        color: Colors.yellow,
                        title: "Validar Codigo",
                        height: 50,
                        fontsize: 16),
                  )
                ],
              ),
            )));
  }
}
