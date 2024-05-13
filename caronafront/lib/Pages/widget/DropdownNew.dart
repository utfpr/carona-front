import 'package:flutter/material.dart';

class DropDownTile extends StatelessWidget {
  DropDownTile({required this.legend,required this.drop,super.key});

  DropdownButtonFormField drop;
  String legend;
  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(legend),
      SizedBox(height: 10,),
      drop
    ],);
  }
}