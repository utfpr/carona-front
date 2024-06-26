import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class MotoPassContainer extends StatelessWidget {
  MotoPassContainer({required this.user, required this.race, super.key});
  Race race;
  User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.125 + 3,
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white.withOpacity(0.075)),
                child: Center(
                    child: Text(
                  (race.motorist.id == user.id) ? "Motorista" : "Passageiro",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ))))
      ],
    );
  }
}
