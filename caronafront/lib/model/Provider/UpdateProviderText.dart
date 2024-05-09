import 'dart:io';

import 'package:flutter/material.dart';

class UpdateProviderText with ChangeNotifier {
  String _campovalidate="RA";
  bool _check=false;

  String get campovalidate=>_campovalidate;
  bool get check=>_check;
  void setcampo(String value){
    _campovalidate=value;
    _check=!_check;
    notifyListeners();
  }
}