import 'package:caronafront/model/Usermoel.dart';
import 'package:flutter/material.dart';

class UpdateProviderText with ChangeNotifier {
  String _campovalidate="Email";
  bool _check=false;
  User? user=null;
  String get campovalidate=>_campovalidate;
  bool get check=>_check;
  void sethavecar(){
    user!.havebutton=!user!.havebutton;
    notifyListeners();
  }
  void setcampo(String value){
    _campovalidate=value;
    _check=!_check;
    notifyListeners();
  }
}