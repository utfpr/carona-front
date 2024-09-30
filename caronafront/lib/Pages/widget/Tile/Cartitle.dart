import 'package:caronafront/Pages/CarPages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/PageValidate/PageValidateUsing/CarRemoveValidate.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonCarDefault.dart';
import 'package:caronafront/Pages/widget/Text/TextModelColor.dart';
import 'package:caronafront/Pages/widget/Text/TextPlate.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class CarTitle extends StatelessWidget {
  const CarTitle(
      {required this.provider,
      required this.user,
      required this.car,
      super.key});
  final Car car;
  final User user;
  final UpdateProviderCar provider;

  void remover(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) =>
            CarRemoveValidate(car: car, provider: provider, userauth: user)));
  }

  void update(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) =>
            CarRegisterPage(car: car, user: user, butt: "Atualizar carro")));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Color(0xFF0E0B13),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextModelColor(car: car),
              Row(
                children: [
                  IconButton(
                    color: Colors.yellow,
                    iconSize: 23,
                    onPressed: () => update(context),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                      color: Colors.yellow,
                      iconSize: 23,
                      onPressed: () => remover(context),
                      icon: const Icon(Icons.delete_outline))
                ],
              )
            ],
          ),
        ),
      ),
      Container(
        color: Color(0xFF0E0B13),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPlate(car: car),
              ButtonCarDeafault(
                car: car,
                provider: provider,
              )
            ],
          ),
        ),
      )
    ]);
  }
}
