import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providerpassword with ChangeNotifier {
  List<bool>  _isvisible = [true, true, true, true, true, true];
  List<bool> get isvisible => _isvisible;
  void visibleandnot(int pos) {
    _isvisible[pos] = !_isvisible[pos];
    notifyListeners();
  }
}
