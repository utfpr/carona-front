
import 'package:caronafront/Pages/Racepage.dart';
import 'package:caronafront/Pages/RegisterUser.dart';
import 'package:caronafront/model/Provider/UpdateProvider.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterUser()));
  }
  @override
  Widget build(BuildContext acontext) {
    return Scaffold(
        body:Center(child: Container(
        padding: EdgeInsets.fromLTRB(0, 200, 0,0),
        color: Colors.black45,
        child:Column(
        children: [
          Center(
        child: SizedBox(
          width: 0.6*MediaQuery.of(context).size.width,
          child: Column(children: [
          Text("Email"),
          TextFormField(
          validator: (value){
            if(email.length>3) return "O campo deve conter pelo menos três caracteres";
          },
          keyboardType: TextInputType.emailAddress,
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
        TextFormField(
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        validator: (value){
          if(password.length>5) return "O campo deve conter pelo menos cinco caracteres";
        },
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
              final response=await APIservicosUser.auth(email, password);
              if (response!=null) {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RacePage(response,true)));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tente Novamente")));
              }
            },
            child: Container(color: Color(0xFF695E19),
            child: Center(child: Text("Login")),)),
          ),SizedBox(height: 60,),
          TextButton(onPressed:(){
            navigator(context);
          },style: ButtonStyle(tapTargetSize:MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return Colors.transparent;
      },
    ),),child:Text("Seja bem-vindo! Cadastre-se",
     style: TextStyle(decoration: TextDecoration.underline),))
        ],
        )
      ,),
      )
      );
  }
}
