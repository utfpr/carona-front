import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonBarNew extends StatelessWidget {
  ButtonBarNew(
      {super.key,
      required Color this.color,
      required String this.title,
      required double this.height,
      required double this.fontsize});
  Color color;
  String title;
  double height;
  double fontsize;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      transformAlignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
        title,
        style: TextStyle(fontSize: fontsize, color: Colors.black),
      ),
      )
    );
  }
}
