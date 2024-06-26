import 'package:flutter/material.dart';
class Textlabel extends StatelessWidget {
  Textlabel({required this.label,super.key});
  String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
      child: Container(
        width: 150,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.075)),
        child: Center(
            child: Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white),
        )),
      ),
    );
  }
}