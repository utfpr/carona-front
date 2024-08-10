import 'package:caronafront/Pages/widget/Cartitle.dart';

import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarList extends StatelessWidget {
  const CarList({required User this.user, required this.ctx, super.key});
  final BuildContext ctx;
  final User user;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateProviderCar>(ctx);
    provider.getcarlist(user.id);
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: provider.listcar.length,
                (context, index) => Padding(
                    padding: EdgeInsets.all(16),
                    child: Card.outlined(
                      child: CarTitle(
                        user: user,
                        car: provider.listcar
                            .elementAt(provider.listcar.length - index - 1),
                        provider: provider,
                      ),
                    ))))
      ],
    );
  }
}
