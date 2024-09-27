import 'package:caronafront/Pages/UserPages/RegisterUser.dart';
import 'package:caronafront/Pages/widget/DrawerAppBar/AppBarCustom.dart';
import 'package:caronafront/Pages/widget/Text/TextPolitc.dart';
import 'package:caronafront/Pages/widget/Text/TextinfoCustom.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
// Tela de termos de uso do APP
class PoliticaPage extends StatelessWidget {
  PoliticaPage({required this.user,super.key});
  User? user;
  void back(BuildContext context) {// volta para tela de cadastro do usuário
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => RegisterUser(
              user: user,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.2 * MediaQuery.of(context).size.height),// 20 % do tamanho da pagina
          child: AppBarCustom(
            legend: "Leia com atenção",
            height: 0.2 * MediaQuery.of(context).size.height,
            back: () => back(context),// volta para tela da pagina 
            color: Colors.black12,
          )),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              TextinfoCustom(
                  fontsizeinfo: 18,
                  fontsizelegend: 14,
                  info: TextPolitc.introdution,
                  legend: "1.Introdução"),
              const SizedBox(
                height: 30,
              ),
              TextinfoCustom(
                  fontsizeinfo: 18,
                  fontsizelegend: 14,
                  info: TextPolitc.descriptionservice,
                  legend: "2.Descrição dos Serviços"),
              const SizedBox(
                height: 30,
              ),
              TextinfoCustom(
                  fontsizeinfo: 18,
                  fontsizelegend: 14,
                  info: TextPolitc.descriptionservice,
                  legend: "3.Responsabilidades do Usuário"),
              const SizedBox(
                height: 30,
              ),
              TextinfoCustom(
                  fontsizeinfo: 18,
                  fontsizelegend: 14,
                  info: TextPolitc.propriety,
                  legend: "4.Propriedade Intelectual"),
              const SizedBox(
                height: 30,
              ),
              TextinfoCustom(
                  fontsizeinfo: 18,
                  fontsizelegend: 14,
                  info: TextPolitc.limitresponse,
                  legend: "5.Limitação de Responsabilidade"),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "6.Dados Sensíveis",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic1,
                      legend: "6.1 Tipos de Dados Coletados")),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic2,
                      legend: "6.2 Finalidade da Coleta")),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic2,
                      legend: "6.2 Finalidade da Coleta")),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic3,
                      legend: "6.3 Armazenamento e Segurança")),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic4,
                      legend: "6.4 Compartilhamento de Dados")),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic5,
                      legend: "6.5 Direitos dos Usuários")),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextinfoCustom(
                      fontsizeinfo: 18,
                      fontsizelegend: 14,
                      info: TextPolitc.topic6,
                      legend: "6.6 Contato para Dúvidas"))
            ],
          )),
    );
  }
}
