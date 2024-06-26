import 'package:caronafront/Pages/widget/HistoryTile.dart';
import 'package:caronafront/model/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedingList extends StatelessWidget {
  const PedingList({required User this.user, required this.ctx, super.key});
  final BuildContext ctx;
  final User user;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadateRace>(ctx);
    provider.getcarpeding(user.id);
    return RefreshIndicator(
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: provider.racespending.length,
                    (context, index) => Padding(
                        padding: EdgeInsets.all(16),
                        child: Card.outlined(
                          elevation: 10,
                          shadowColor: Color.fromARGB(38, 255, 255, 255),
                          child: HistoryTile(
                              user,
                              provider.racespending.elementAt(
                                  provider.racespending.length - index - 1)),
                        ))))
          ],
        ),
        onRefresh: () async => provider.getcarpeding(user.id));
  }
}
