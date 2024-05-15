import 'dart:ffi';

import 'package:caronafront/Pages/widget/RaceTitle.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  OfferList({required this.user, required this.provider, super.key});
  UpadateRace provider;
  User user;
  @override
  Widget build(BuildContext context) {
    provider.getallraces(user.id);
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: provider.racesoffer.length,
                (context, index) => Padding(
                    padding: EdgeInsets.all(16),
                    child:
                        RaceTile(user, provider.racesoffer.elementAt(index)))))
      ],
    );
  }
}
