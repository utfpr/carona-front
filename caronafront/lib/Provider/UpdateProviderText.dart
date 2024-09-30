// ignore: file_names
import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class UpdateProviderText with ChangeNotifier {
  String _campovalidate="RA";
  bool _check=false;
  User? user;
  String get campovalidate=>_campovalidate;
  bool get check=>_check;
  void sethavecar(){
    user!.havebutton=!user!.havebutton;
    notifyListeners();
  }
  void setname(String value){
    _campovalidate=value;
    _check=!_check;
    notifyListeners();
  }
}