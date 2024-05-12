import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class CarList extends StatelessWidget {
  const CarList({required User this.user, required this.ctx, super.key});
  final BuildContext ctx;
  final User user;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 66,itemBuilder: (ctx,index)=>Padding(padding:EdgeInsets.all(16),child:CarTitle(user: user, car: Car("", "pLACA", "jaca", false, "JACA", createdAt: null, updateAt: null))));
  }
}
