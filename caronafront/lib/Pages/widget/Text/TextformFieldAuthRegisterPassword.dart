import 'package:caronafront/Provider/Providerpassword.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class TextFormFieldAuthRegisterPassword extends StatelessWidget {
  TextFormFieldAuthRegisterPassword(
      {required this.number,
      required this.tipo,
      required this.validate,
      required this.legend,
      required this.controller,
      required this.space,
      super.key});
  final double space;
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
            width: 0.9 * MediaQuery.of(context).size.width,
            child: TextFormField(
              obscureText: provider.isvisible[number],
              controller: controller,
              keyboardType: tipo,
              validator: validate,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: GestureDetector(
                      onTap: () => provider.visibleandnot(number),
                      child: (provider.isvisible[number])
                          ? const Icon(Iconsax.eye)
                          : const Icon(Iconsax.eye_slash))),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ));
    });
  }
}
