import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class   CarList extends StatelessWidget {
  const CarList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarTitle(user: User("", "", "", "", 
      createdAt: null, updateAt: null), 
      car: Car("", "AAAJKL7", "JACA MADURA", 
      "", createdAt: null, updateAt: null)),
      CarTitle(user: User("", "", "", "", 
      createdAt: null, updateAt: null), 
      car: Car("", "AAAJKL7", "JACA MADURA", 
      "", createdAt: null, updateAt: null)
      ), CarTitle(user: User("", "", "", "", 
      createdAt: null, updateAt: null), 
      car: Car("", "AAAJKL7", "JACA MADURA", 
      "", createdAt: null, updateAt: null))
    ],);
  }
}