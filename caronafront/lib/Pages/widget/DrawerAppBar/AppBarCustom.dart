// ignore: file_names
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatefulWidget {
  AppBarCustom(
      {required this.height,
      required this.legend,
      required this.color,
      required this.back,
      this.user,
      this.isyellow = false});

  void Function()? back;
  double height;
  String legend;
  User? user;
  Color color;
  bool isyellow;
  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: widget.height,
        leading: (widget.back != null)
            ? IconButton(
                onPressed: widget.back, icon: const Icon(Icons.arrow_back_ios))
            : null,
        backgroundColor: widget.color,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (widget.user != null)
                        ? Text(
                            widget.user!.name,
                            style: TextStyle(
                                fontSize: 20, color:widget.isyellow ? Colors.yellow : Colors.white),
                          )
                        : const Text("Politica de Privacidade"),
                  ]),
              Text(
                widget.legend,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15),
              ),
            ]));
  }
}
