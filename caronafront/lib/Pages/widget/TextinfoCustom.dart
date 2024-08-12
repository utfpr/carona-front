import 'package:flutter/material.dart';

class TextinfoCustom extends StatelessWidget {
  const TextinfoCustom({required this.fontsizeinfo,required this.fontsizelegend, required this.info,
  required String this.legend,super.key});

  final String legend;
  final String info;
  final double fontsizeinfo;
  final double fontsizelegend;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(legend,style: TextStyle(fontSize: fontsizeinfo ),),
      SizedBox(height: 20,),
      Text(info,style: TextStyle(fontSize:fontsizelegend,color: Colors.white ),)
    ],);
  }
}