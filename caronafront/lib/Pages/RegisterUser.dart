
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterUser> {
  bool obscureText=true;
  String password="";
  String email="";
  String name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Center(child: Container(
        padding: EdgeInsets.fromLTRB(0, 200, 0,0),
        color: Colors.black45,
        child:Column(
        children: [
         Center(
         child: SizedBox(
          width: 0.6*MediaQuery.of(context).size.width,
          child: Column(children: [
          Text("Nome"),
          TextFormField(keyboardType: TextInputType.text,
          onChanged: (value){
            setState(() {
              name=value.trim();
            });
          },)
          ],)
        )),SizedBox(height: 30,),
        Center(
        child: SizedBox(
          width: 0.6*MediaQuery.of(context).size.width,
          child: Column(children: [
          Text("Email"),
          TextFormField(keyboardType: TextInputType.emailAddress)
          ],)
        )), SizedBox(height: 30,),
        Center(
        child: SizedBox(
          width: 0.6*MediaQuery.of(context).size.width,
          child:Column(
        children: [
        Text("Senha"),
        TextFormField(keyboardType: TextInputType.text,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon:IconButton(
            icon:Icon(   
               obscureText
               ? Icons.visibility
               : Icons.visibility_off,
               color: Colors.white,
               ),
            onPressed: () {
               setState(() {
                   obscureText = !obscureText;
               });
             },
            ),
        ),
        onChanged: (value){
          setState(() {
            password=value.trim();
          });
        },
      ),
      ],)
        )
        ),SizedBox(height:60 ),
          SizedBox(
            height: 50,
            width: 0.6*MediaQuery.of(context).size.width,
            child: GestureDetector(
            onTap: ()async{
              int response=await APIservicosUser.createuser(name, email, password);
              if (response==0) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("usuário foi criado com sucesso!")));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("O usuário não pode ser cadastrado.")));
              }
            },
            child:Container(color: Color(0xFF695E19),
            child: Center(child: Text("Cadastrar")),
            ),
          )),SizedBox(height: 30,),
          TextButton(onPressed:(){
            Navigator.of(context).pop();
          },style: ButtonStyle(tapTargetSize:MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Colors.transparent;
      },
    ),),child:Text("Voltar", style: TextStyle(decoration: TextDecoration.underline),))],
        )
      ,),)
      );
  }
}