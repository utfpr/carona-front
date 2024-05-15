import 'package:caronafront/Pages/widget/HistoryTile.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatelessWidget {
  HistoryList({required this.user,required this.providerrace, super.key});
  User user;
  UpadateRace providerrace;
  @override
  Widget build(BuildContext context) {
    providerrace.historic(user.id);
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(childCount:providerrace.historicraces.length ,(context, index) => Padding(
                  padding: EdgeInsets.all(16),
                  child: HistoryTile(
                  user,providerrace.historicraces.elementAt(index)
                ))))
      ],
    );
  }
}
