import 'package:flutter/material.dart';

class CheckBoxLinker extends StatelessWidget {
  CheckBoxLinker(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged,
      required this.navigator});
  bool? value;
  void Function(bool?)? onChanged;
  void Function() navigator;
  String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        TextButton(
            onPressed: navigator,
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              text,
              style: const TextStyle(decoration: TextDecoration.underline),
            ))
      ],
    );
  }
}
