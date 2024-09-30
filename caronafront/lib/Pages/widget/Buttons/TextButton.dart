// ignore: file_names
import 'package:flutter/material.dart';

class TextLinkerButton extends StatelessWidget {
  TextLinkerButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  void Function()? onPressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: const TextStyle(decoration: TextDecoration.underline),
        ));
  }
}
