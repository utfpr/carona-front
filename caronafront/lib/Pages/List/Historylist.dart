import 'package:caronafront/Pages/widget/HistoryTile.dart';
import 'package:caronafront/Pages/widget/HistoryTilePassager.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  HistoryList({required this.user, required this.providerrace, super.key});
  User user;
  UpadateRace providerrace;
  @override
  Widget build(BuildContext context) {
    providerrace.historic(user.id);
    return RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: providerrace.historicraces.length,
                    (context, index) => Padding(
                        padding: EdgeInsets.all(16),
                        child: Card.outlined(
                            elevation: 10,
                            shadowColor: Color.fromARGB(38, 255, 255, 255),
                            child: HistoryTileEnd(
                                authuser: user,
                                race: providerrace.historicraces
                                    .elementAt(index))))))
          ],
        ),
        onRefresh: () async => providerrace.historic(user.id));
  }
}
