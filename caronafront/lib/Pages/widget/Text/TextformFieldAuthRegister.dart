import 'package:flutter/material.dart';

class TextFormFieldAuthRegister extends StatelessWidget {
  TextFormFieldAuthRegister(
      {required this.tipo,
      required this.validate,
      required this.legend,
      required this.controller,
      required this.space,
      super.key});
  final String legend;
  final TextEditingController controller;
  final double space;
  final String? Function(String?) validate;
  final TextInputType tipo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(legend),
        SizedBox(
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            controller: controller,
            keyboardType: tipo,
            validator: validate,
          ),
        ),
        SizedBox(
          height: space,
        ),
      ],
    ));
  }
}
