import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/Profile.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
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
  void senddatacarbackdelete(String car_id, BuildContext context) async {
    final response = await APIservicosCar.deletecar(car_id);
    if (response == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Carro deletado com sucesso")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Não foi possível deletar este carro. Tente novamente")));
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => Profile(user: user)));
  }

  void remover(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Carvalidate(
            user: user,
            back: (){Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx)=>Profile(user: user)));},
            tile1: Textinfo(info: car.plate, legend: "Placa do carro"),
            tile2: Textinfo(info: car.modelcolor, legend: "Modelo e Cor"),
            funct: () => senddatacarbackdelete(car.id, ctx),
            buttom: ButtonBarNew(
              color: Colors.red,
              fontsize: 16,
              height: 50,
              title: "Remover",
            ))));
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Modelo e cor",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.2), fontSize: 14),
                    ),
                    Text(
                      car.modelcolor,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ]),
              Row(
                children: [
                  IconButton(
                    iconSize: 18,
                    onPressed: () => update(context),
                    icon: Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                      iconSize: 18,
                      onPressed: () => remover(context),
                      icon: Icon(Icons.delete_outline))
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
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Placa",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.2), fontSize: 14),
                    ),
                    Text(
                      car.plate,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ]),
              (car.mainCar == false)
                  ? GestureDetector(
                      onTap: () => provider.cardefault(Car(car.id, car.plate,
                          car.modelcolor, true, car.user,
                          createdAt: car.createdAt, updateAt: car.updateAt)),
                      child: ButtonBarNew(
                          color: Colors.white.withOpacity(0.2),
                          title: "Carro como Padrão",
                          height: 25,
                          fontsize: 10))
                  : Text(
                      "Padrão",
                      style: TextStyle(fontSize: 12),
                    )
            ],
          ),
        ),
      )
    ]);
  }
}
