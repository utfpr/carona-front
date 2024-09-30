import 'package:caronafront/model/Carmodel.dart';
import 'package:flutter/material.dart';

class TextModelColor extends StatelessWidget {
  TextModelColor({required this.car, super.key});
  Car car;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Modelo e cor",
            style:
                TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14),
          ),
          Text(
            car.modelcolor,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ]);
  }
}
