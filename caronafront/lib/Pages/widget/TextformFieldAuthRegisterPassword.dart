

import 'package:caronafront/model/Provider/Providerpassword.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          SizedBox(
            height: 10,
          ),
          Text(legend),
          Row(
            children: [
              Expanded(
                  child: SizedBox(
                child: TextFormField(
                  obscureText: provider.isvisible[number],
                  controller: controller,
                  keyboardType: tipo,
                  validator: validate,
                ),
              )),
              GestureDetector(
                  onTap: () => provider.visibleandnot(number),
                  child: (provider.isvisible[number])
                      ? Icon(Icons.visibility_outlined)
                      : Icon(Icons.visibility_off_outlined)),
            ],
          )
        ],
      ));
    });
  }
}
