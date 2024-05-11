import 'package:caronafront/Pages/widget/RaceTitle.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(delegate: SliverChildBuilderDelegate((context, index) => Padding(padding:EdgeInsets.all(16),child:RaceTile(Race("", "UTF", "Cafe Mais 1", 
      User("", "", "", "", false, "", 
      createdAt: null, updateAt: null), "", "", 
      [], 3, createdAt: null, updateAt: null)))))
    ],);
  }
}