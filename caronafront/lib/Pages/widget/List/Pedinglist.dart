import 'package:caronafront/Pages/widget/Tile/HistoryTile.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedingList extends StatelessWidget {
  const PedingList({required User this.user, required this.ctx, super.key});
  final BuildContext ctx; // contexto da pagina anterior
  final User user;// usuario autenticado
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpadateRace>(ctx);// gerianciador de estado
    provider.getracepeding(user.id); // pegar as corridas pedentes
    return RefreshIndicator(
        child: OrientationBuilder(builder: (context, oriental) {
          if (oriental == Orientation.portrait) {
            return PedingListPortrait(provider: provider, user: user); // altera o tamanho do card na horizontal 
          } else {
            return PedingListLendspace(provider: provider, user: user); // altera o tamanho do card na vertical
          }
        }),
        onRefresh: () async => provider.getracepeding(user.id)); // realiza o refresh do card
  }
}

class PedingListLendspace extends StatelessWidget {
  const PedingListLendspace({
    super.key,
    required this.provider,
    required this.user,
  });

  final UpadateRace provider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: provider.racespending.length,
                (context, index) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: HistoryTile(
                          user,
                          provider.racespending.elementAt(
                              provider.racespending.length -
                                  index -
                                  1),0.52),
                    )))
      ],
    );
  }
}

class PedingListPortrait extends StatelessWidget {
  const PedingListPortrait({
    super.key,
    required this.provider,
    required this.user,
  });

  final UpadateRace provider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: provider.racespending.length,
                (context, index) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: HistoryTile(
                          user,
                          provider.racespending.elementAt(
                              provider.racespending.length -
                                  index -
                                  1),0.28),
                    )))
      ],
    );
  }
}
