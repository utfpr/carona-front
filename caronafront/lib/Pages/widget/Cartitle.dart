import 'package:caronafront/Pages/CarRegistrationPage.dart';
import 'package:caronafront/Pages/Carvalidadate.dart';
import 'package:caronafront/Pages/widget/ButtonBar.dart';
import 'package:caronafront/Pages/widget/Textinfo.dart';
import 'package:caronafront/model/Carmodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:caronafront/servicos/APIservicosCar.dart';
import 'package:flutter/material.dart';

class CarTitle extends StatelessWidget {
  const CarTitle({required this.user, required this.car, super.key});
  final Car car;
  final User user;
  void senddatacarbackdelete(String car_id, BuildContext context) async {
    final response = await APIservicosCar.deletecar(car_id);
    if (response == -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Carro deletado com sucesso")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Não foi possível deletar este carro. Tente novamente")));
    }
  }

  void remover(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Carvalidate(
            user: user,
            tile1: Textinfo(info: car.plate, legend: "Placa do carro"),
            tile2: Textinfo(info: car.modelcolor, legend: "Modelo e Cor"),
            funct: () => senddatacarbackdelete(car.id,context),
            buttom: ButtonBarNew(
              color: Colors.red,
              fontsize: 16,
              height: 50,
              title: "Remover",
            ))));
  }

  void update(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            CarRegisterPage(car: car, user: user, butt: "Atualizar carro")));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListTile(
                tileColor: Color(0xFF0E0B13),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(value: car.mainCar, onChanged: (value){

                    }),
                    IconButton(
                      onPressed: () => remover(context),
                      icon: Icon(
                        Icons.delete_outlined,
                        size: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () => update(context),
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                title: Text(
                  "placa do carro",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.2), fontSize: 14),
                ),
                subtitle: Text(
                  car.plate,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
                height: 70,
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  tileColor: Color(0xFF0E0B13),
                  title: Text(
                    "modelo e cor ",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.2), fontSize: 14),
                  ),
                  subtitle: Text(
                    car.modelcolor,
                    style: TextStyle(fontSize: 16),
                  ),
                ))
          ],
        ));
  }
}
