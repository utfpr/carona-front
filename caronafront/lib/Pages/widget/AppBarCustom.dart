import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AppBarCustom extends StatefulWidget {
  AppBarCustom({required this.height,required this.legend,required this.color,required this.back,required this.user,super.key});
  void Function()? back;
  double height;
  String legend;
  User user;
  Color color;
  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
         toolbarHeight: widget.height,
        leading:(widget.back!=null)?IconButton(onPressed:widget.back , icon: Icon(Icons.arrow_back_ios)):null,
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
                    Text(
                      "${widget.user.name}",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ]),Text(
                widget.legend,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ]));
  }
}