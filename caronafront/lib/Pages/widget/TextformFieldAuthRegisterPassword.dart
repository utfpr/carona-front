import 'package:caronafront/model/Provider/Providerpassword.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TextFormFieldAuthRegisterPassword extends StatelessWidget {
  TextFormFieldAuthRegisterPassword(
      {required this.number,
      required this.tipo,
      required String? Function(String?) this.validate,
      required String this.legend,
      required TextEditingController this.controller,
      super.key});
  final String legend;
  final TextEditingController controller;
  final String? Function(String?) validate;
  final TextInputType tipo;
  int number;
  @override
  Widget build(BuildContext context) {
    return Consumer<Providerpassword>(builder: (context, provider, child) {
      return SizedBox(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Text(legend),
          SizedBox(
            width: 0.9*MediaQuery.of(context).size.width,
            child: TextFormField(
              obscureText: provider.isvisible[number],
              controller: controller,
              keyboardType: tipo,
              validator: validate,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () => provider.visibleandnot(number),
                      child: (provider.isvisible[number])
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined))),
            ),
          ),
        ],
      ));
    });
  }
}
