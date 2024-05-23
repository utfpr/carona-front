
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
  TextEditingController senha_text = TextEditingController();
  TextEditingController ra_email = TextEditingController();
  void navigator(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterUser()));
  }
  void authemail(String email,String senha,GlobalKey<FormState> key)async{
    User? response=await APIservicosUser.auth(email, senha);
    if (key.currentState!.validate() && response!=null) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RacePage(response)));
       ra_email.clear();
       senha_text.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tente Novamente")));
    }
  }
  void authra(String ra,String senha,GlobalKey<FormState>key)async{
    User? response=await APIservicosUser.authra(ra, senha);
    if (key.currentState!.validate() && response!=null) {
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>RacePage(response)));
       ra_email.clear();
       senha_text.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tente Novamente")));
    }
  }
 String? validatoremail(String? value) {
    if (!value!.contains("@")) {
      return "Falta o Caracter @";
    }
    return null;
  }

  String? validatorpassword(String? value) {
    RegExp regex = RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:\<>\./\?\\|`~]');
    RegExp regexpmaiscula = RegExp(r'[A-Z]');
    RegExp regexminuscula = RegExp(r'[a-z]');
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
    GlobalKey<FormState>key=GlobalKey<FormState>();
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
      child: Form(
        key: key,
        child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 80,
          ),
          TextFormFieldAuthRegister(
              obscure: false,
              tipo: TextInputType.emailAddress,
              validate:(provider.check==false)?validatoremail:validatera,
              legend: provider.campovalidate,
              controller: ra_email),
          SizedBox(
            height: 20,
          ),
          TextFormFieldAuthRegister(
              obscure: true,
              tipo: TextInputType.name,
              validate: validatorpassword, legend: "Senha", controller: senha_text),
          SizedBox(
            height: 40,
          ),
          GestureDetector(onTap:(provider.check==false)?()=>authemail(ra_email.text, senha_text.text,key):()=>authra(ra_email.text,senha_text.text,key),child: ButtonBarNew(color: Colors.yellow, title: "LOGIN", height: 50, fontsize:16),),
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
      ),)
    ));
  }
}
