import 'package:caronafront/model/Racemodel.dart';
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MotoPassContainer extends StatelessWidget {
  MotoPassContainer({required this.user, required this.race, super.key});
  Race race;
  User user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
                width: 150,
                height: 20,
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (race.motorist.id == user.id) ? Colors.yellow : Colors.white.withOpacity(0.075)),
                child: Center(
                    child: Text(
                  (race.motorist.id == user.id) ? "Motorista" : "Passageiro",
                  style: TextStyle(fontSize: 12, color: (race.motorist.id != user.id) ? Colors.yellow : Colors.black),
                ))))
      ],
    );
  }
}
