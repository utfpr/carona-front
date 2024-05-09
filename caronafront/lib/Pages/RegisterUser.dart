import 'package:caronafront/Pages/AuthUser.dart';
import 'package:caronafront/servicos/APIsetvicosUser.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterUser> {
  
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            
          ],
        ),
      );
  }
}
