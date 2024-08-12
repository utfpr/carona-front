import 'package:flutter/material.dart';

class TextFormFieldTile extends StatelessWidget {
  const TextFormFieldTile({required int this.leght,required String this.legend,required String this.hint,
  required TextEditingController this.controller,required this.value,this.type=null,super.key});
  final String legend;
  final String hint;
  final int leght;
  final TextInputType? type;
  final String? Function(String?) value;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(legend,),
        SizedBox(height:10),
        TextFormField(
          maxLength:leght,
          controller: controller,
          validator: value,
          keyboardType: type,
          decoration:InputDecoration(
            hintText:hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10))
          ),
        )
      ],
    );
  }
}