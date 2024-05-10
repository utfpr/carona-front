import 'package:caronafront/Pages/widget/Cartitle.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class   CarList extends StatelessWidget {
  const CarList({required User this.user,required List<Car> this.listcar,super.key});
  final List<Car> listcar;
  final User user;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount:3,
          (context, index)=>CarTitle(user: user , car:Car("", "AAJK123", "Civic Roxo", true, "", createdAt: null, updateAt: null),)),)
    ],);
  }
}