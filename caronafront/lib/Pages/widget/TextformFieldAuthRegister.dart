import 'package:flutter/material.dart';

class TextFormFieldAuthRegister extends StatelessWidget {
  TextFormFieldAuthRegister({required this.obscure, required this.tipo,required  String? Function(String?) this.validate,required String this.legend,
  required TextEditingController this.controller ,super.key});
  final String legend;
  final TextEditingController controller;
  final String? Function(String?) validate;
  bool obscure;
  final TextInputType tipo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Center(child:Text(legend)),
        SizedBox(
        child:TextFormField(
        obscureText: obscure,
        controller: controller,
        keyboardType: tipo,
        validator: validate,))
      ],
    )
    );
  }
}