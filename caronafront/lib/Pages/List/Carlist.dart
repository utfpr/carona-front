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
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => CarTitle(
                    user: user,                  
                    car: Car("", "AAJK123", "Civic Roxo", false, "",
                        createdAt: null, updateAt: null),
                  )),
        )
      ],
    );
  }
}
