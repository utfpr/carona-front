import 'package:caronafront/Pages/CarPages/CarHomePage.dart';
import 'package:caronafront/Pages/PageValidate/Carvalidadate.dart';
import 'package:caronafront/Pages/widget/Buttons/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Text/Textinfo.dart';
import 'package:caronafront/Provider/UpdateProviderCar.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class CarRemoveValidate extends StatelessWidget {
  CarRemoveValidate(
      {required this.car,
      required this.provider,
      required this.userauth,
      super.key});
  Car car;
  User userauth;
  UpdateProviderCar provider;

  void senddatacarbackdelete(int car_id, BuildContext context) async {
    final response = await APIservicosCar.deletecar(car_id);
    if (response == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Carro deletado com sucesso")));
      provider.deletarcar(car_id);
      if (provider.listcar.isEmpty) {
        userauth.havebutton = false;
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Não foi possível deletar este carro. Tente novamente")));
    }
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => CarHomePage(user: userauth)));
  }

  @override
  Widget build(BuildContext context) {
    return Carvalidate(
        user: userauth,
        back: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => CarHomePage(user: userauth))),
        tile1: Textinfo(
          info: car.plate,
          legend: "Placa do carro",
          fontsizeinfo: 16,
          fontsizelegend: 14,
        ),
        tile2: Textinfo(
          info: car.modelcolor,
          legend: "Modelo e Cor",
          fontsizeinfo: 16,
          fontsizelegend: 14,
        ),
        funct: () => senddatacarbackdelete(car.id, context),
        buttom: ButtonBarNew(
          color: Colors.red,
          fontsize: 16,
          height: 50,
          title: "Remover",
        ));
  }
}
