import 'package:flutter/material.dart';


class Imagecustom extends StatelessWidget {
  Imagecustom(
      {super.key,
      required this.height,
      required this.width,
      required this.horizontal,
      required this.vertical,
      required this.imageurl});
  double width;
  double height;
  double horizontal;
  double vertical;
  String imageurl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child:
          SizedBox(height: height, width: width, child: Image.asset(imageurl)),
    );
  }
}
