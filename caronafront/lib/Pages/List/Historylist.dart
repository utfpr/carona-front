
import 'package:caronafront/Pages/widget/HistoryTilePassager.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HistoryList extends StatelessWidget {
  HistoryList({required this.user, required this.providerrace, super.key});
  User user;
  UpadateRace providerrace;
  @override
  Widget build(BuildContext context) {
    providerrace.historic(user.id);
    return RefreshIndicator(
        child: OrientationBuilder(builder: (context, portion) {
          if (portion == Orientation.portrait) {
            return CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: providerrace.historicraces.length,
                        (context, index) => Padding(
                            padding: EdgeInsets.all(16),
                            child: HistoryTileEnd(
                                authuser: user,
                                width: 0.255,
                                race: providerrace.historicraces
                                    .elementAt(index)))))
              ],
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: providerrace.historicraces.length,
                        (context, index) => Padding(
                            padding: EdgeInsets.all(16),
                            child: HistoryTileEnd(
                                width: 0.505,
                                authuser: user,
                                race: providerrace.historicraces
                                    .elementAt(index)))))
              ],
            );
          }
        }),
        onRefresh: () async => providerrace.historic(user.id));
  }
}
