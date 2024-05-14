import 'dart:ffi';

import 'package:caronafront/Pages/widget/RaceTitle.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  OfferList({required this.provider,super.key});
  UpadateRace provider;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(delegate: SliverChildBuilderDelegate(childCount:provider.racesoffer.length,(context, index) => Padding(padding:EdgeInsets.all(16),child:RaceTile(provider.racesoffer.elementAt(index)))))
    ],);
  }
}
