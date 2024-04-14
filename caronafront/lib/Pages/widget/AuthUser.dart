
import 'package:caronafront/Pages/RegisterUser.dart';
import 'package:flutter/material.dart';

class AuthUser extends StatefulWidget {
  const AuthUser({super.key});

  @override
  State<AuthUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AuthUser> {
  bool obscureText=true;
  String password="";
  String email="";
  void navigator(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterUser()));
  }
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
          Text("Email"),
          TextFormField(keyboardType: TextInputType.emailAddress,
          onChanged: (value){
          setState(() {
            email=value.trim();
          });
        },),
          
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
            child: Container(color: Color(0xFF695E19),
            child: Center(child: Text("Login")),),
          ),SizedBox(height: 60,),
          TextButton(onPressed:(){
            navigator(context);
          },style: ButtonStyle(tapTargetSize:MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Colors.transparent;
      },
    ),),child:Text("Seja bem-vindo! Cadastre-se", style: TextStyle(decoration: TextDecoration.underline),))
        ],
        )
      ,),)
      );
  }
}