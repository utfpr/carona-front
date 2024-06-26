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
    return RefreshIndicator(
        child: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: provider.racesoffer.length,
                  (context, index) => Padding(
                      padding: EdgeInsets.all(16),
                      child: Card.outlined(
                        elevation: 10,
                        shadowColor: Color.fromARGB(38, 255, 255, 255),
                        child: RaceTile(
                          user, provider.racesoffer.elementAt(index))))))
        ]),
        onRefresh: () async => provider.getallraces(user.id));
  }
}
