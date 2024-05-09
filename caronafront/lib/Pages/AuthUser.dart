
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/RegisterUser.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/TextformFieldAuthRegister.dart';
import 'package:caronafront/model/Provider/UpdateProviderText.dart';
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
  TextEditingController senha = TextEditingController();
  TextEditingController ra_email = TextEditingController();
  void navigator(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterUser()));
  }
  void authemail(String email,String senha)async{
    User? response=await APIservicosUser.auth(email, senha);
    if (response!=null) {
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RacePage(response)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tente Novamente")));
    }
  }
  void authra(String ra,String senha){

  }
  String? validateraemail(String? value) {}
  String? validatorpassword(String? value) {}
  @override
  Widget build(BuildContext acontext) {
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
          "Seja bem-vindo! Cadastre-se",
          style: TextStyle(decoration: TextDecoration.underline),
        ));
    final provider = Provider.of<UpdateProviderText>(context);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(32),
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 80,
          ),
          TextFormFieldAuthRegister(
              validate: validateraemail,
              legend: provider.campovalidate,
              controller: ra_email),
          SizedBox(
            height: 20,
          ),
          TextFormFieldAuthRegister(
              validate: validatorpassword, legend: "Senha", controller: senha),
          SizedBox(
            height: 40,
          ),
          GestureDetector(onTap:(provider.check==false)?()=>authemail(ra_email.text, senha.text):()=>authra(ra_email.text,senha.text),),
          SizedBox(
            height: 20,
          ),
          textbutton,
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  activeColor: Colors.white,
                  value: provider.check,
                  onChanged: (value) {
                    if (value == true) {
                      provider.setcampo("RA");
                    } else {
                      provider.setcampo("E-mail");
                    }
                  }),Text("Autenticar com RA")
            ],
          )
        ],
      ),
    ));
  }
}
