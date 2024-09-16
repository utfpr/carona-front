import 'package:caronafront/Pages/widget/Tile/RaceTitle.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';


/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
// ignore: must_be_immutable
class OfferList extends StatelessWidget {// Lista das Corridas Disponíveis 
  OfferList({required this.user, required this.provider, super.key});
  UpadateRace provider;
  User user;
  @override
  Widget build(BuildContext context) {
    provider.getallraces(user.id);
    return RefreshIndicator(
        child: OrientationBuilder(builder: (context, position) {
          if (position == Orientation.portrait) {
            return OfferListPortrait(provider: provider, user: user);// altera os parametros do card na horizontal
          } else {
            return OfferListLandScape(provider: provider, user: user);// altera o parametros do card na vertical
          }
        }),
        onRefresh: () async => provider.getallraces(user.id));
  }
}

class OfferListLandScape extends StatelessWidget {
  const OfferListLandScape({
    super.key,
    required this.provider,
    required this.user,
  });

  final UpadateRace provider;
  final User user;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: provider.racesoffer.length,
              (context, index) => Padding(
                  padding: EdgeInsets.all(16),
                  child: RaceTile(
                      user,
                      provider.racesoffer.elementAt(index),
                      0.3,0.12))))
    ]);
  }
}

class OfferListPortrait extends StatelessWidget {
  const OfferListPortrait({
    super.key,
    required this.provider,
    required this.user,
  });

  final UpadateRace provider;// gerenciador de estado
  final User user; // usuário autenticado

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: provider.racesoffer.length,
              (context, index) => Padding(
                  padding: EdgeInsets.all(16),
                  child: RaceTile(user,
                      provider.racesoffer.elementAt(index), 0.5,0.06))))
    ]);
  }
}
