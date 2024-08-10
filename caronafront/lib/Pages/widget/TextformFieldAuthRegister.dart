
import 'package:flutter/material.dart';

class TextFormFieldAuthRegister extends StatelessWidget {
  TextFormFieldAuthRegister(
      {
      required this.tipo,
      required String? Function(String?) this.validate,
      required String this.legend,
      required TextEditingController this.controller,
      super.key});
  final String legend;
  final TextEditingController controller;
  final String? Function(String?) validate;
  final TextInputType tipo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(legend),
        SizedBox(
          child: TextFormField(
            controller: controller,
            keyboardType: tipo,
            validator: validate,
          ),
        )
      ],
    ));
  }
}
