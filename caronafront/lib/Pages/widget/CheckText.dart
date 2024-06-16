import 'package:caronafront/model/Provider/UpdateProviderText.dart';
import 'package:flutter/material.dart';

class CheckText extends StatelessWidget {
  CheckText({required this.proverider, required this.legend, super.key});
  String legend;
  UpdateProviderText proverider;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
            activeColor: Colors.white,
            value: proverider.check,
            onChanged: (value) {
              if (value == true) {
                proverider.setname("E-mail");
              } else {
                proverider.setname("RA");
              }
            }),
        Text(legend)
      ],
    );
  }
}
