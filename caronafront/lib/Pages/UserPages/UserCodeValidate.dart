import 'package:caronafront/Pages/UserPages/AuthUser.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/TextFormField.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/

class Codepage extends StatelessWidget {
  Codepage({super.key, required this.email});

  String email; // email de envio do codigo
  TextEditingController code = TextEditingController();
  final _formkey = GlobalKey<FormState>();// chave de validação

  String? validate(String? value) { // verifica se o codigo possui 6 caracteres
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

  void validatecode(BuildContext context) async { // envia o codigo para o Back-end
    int response = await APIservicosUser.validate(email, int.parse(code.text));
    if (_formkey.currentState!.validate() && response == 0) {//caso o codigo esteja correto vai para tela de Autenticação 
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => const AuthUser()));
    } else { // caso o codigo não seja valido mostre SnackBar na tela
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
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
                    onTap: () => validatecode(context), // valida o codigo 
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
