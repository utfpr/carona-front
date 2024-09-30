import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:flutter/material.dart';

class ButtonCarDeafault extends StatelessWidget {
  ButtonCarDeafault(
      {required this.car, required this.provider, super.key});
  Car car;
  UpdateProviderCar provider;
  @override
  Widget build(BuildContext context) {
    return (car.mainCar == true)
        ? Text(
            "Carro Padrão",
            style: TextStyle(fontSize: 12),
          )
        : GestureDetector(
            onTap: () => provider.cardefault(Car(
                  car.id,
                  car.plate,
                  car.modelcolor,
                  true,
                  car.user,
                )),
            child: ButtonBarNew(
                color: Colors.yellow,
                title: "Definir como padrão",
                height: 25,
                fontsize: 10));
  }
}
