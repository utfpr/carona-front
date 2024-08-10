import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatetimeContainer extends StatelessWidget {
  DatetimeContainer({required this.label, super.key});
  String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 150,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white.withOpacity(0.075)),
        child: Center(
            child: Text(label,style: TextStyle(fontSize: 12, color: Colors.white),
        )),
      ),
    );
  }
}
