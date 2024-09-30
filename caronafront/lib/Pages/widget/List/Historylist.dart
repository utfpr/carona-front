import 'package:caronafront/Pages/widget/Tile/HistoryTilePassager.dart';
import 'package:caronafront/Provider/UpadateRace.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
/* 
 * Nome: Guilherme Almeida Lopes
 * Data criação e Atualização: 13/09/2024
 * GitHub:alguiguilo098 
*/
class ListHistoric extends StatelessWidget { // design adaptativo na horizontal
  const ListHistoric({
    super.key,
    required this.providerrace, 
    required this.user,
  });

  final UpadateRace providerrace; // gerenciado de estado 
  final User user; // usuário autenticado

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: providerrace.historicraces.length, //recebe o tamanho da lista para determinar quantos cards devem ser renderizados 
                (context, index) => Padding(
                    padding: const EdgeInsets.all(16),// cria uma margem de 16 cm 
                    child: HistoryTileEnd(
                        width: 0.505,
                        authuser: user,
                        race: providerrace.historicraces
                            .elementAt(index)))))
      ],
    );
  }
}

class ListHistoricPortrait extends StatelessWidget { // desgn da lista na horizontal
  const ListHistoricPortrait({
    super.key,
    required this.providerrace,
    required this.user,
  });

  final UpadateRace providerrace;// gerenciador de estado
  final User user; // usuário autenticado 

  @override
  Widget build(BuildContext context) {
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
  }
}

// ignore: must_be_immutable
class HistoryList extends StatelessWidget {
  HistoryList({required this.user, required this.providerrace, super.key});
  User user;
  UpadateRace providerrace;
  @override
  Widget build(BuildContext context) {
    providerrace.historic(user.id);
    return OrientationBuilder(builder: (context, portion) {// altera o estado do widget, com a alteração da posição do celular
          if (portion == Orientation.portrait) {
            return ListHistoricPortrait(providerrace: providerrace, user: user);
          } else {
            return ListHistoric(providerrace: providerrace, user: user);
          }
        });
  }
}


