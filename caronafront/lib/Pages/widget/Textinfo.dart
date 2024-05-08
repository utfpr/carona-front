import 'package:flutter/material.dart';

class Textinfo extends StatelessWidget {
  const Textinfo({required String this.info,
  required String this.legend,super.key});
  final String legend;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(legend,style: TextStyle(fontSize: 14,color: Colors.white.withOpacity(0.4)),),
      SizedBox(height: 10,),
      Text(info,style: TextStyle(fontSize:16,color: Colors.white ),)
    ],);
  }
}