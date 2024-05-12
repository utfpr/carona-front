import 'package:caronafront/model/Racemodel.dart';
import 'package:flutter/material.dart';

class UpadatePassager with ChangeNotifier {
  List<Race>? _race = [];
  List<DropdownMenuItem> _hours = [];
  List<DropdownMenuItem> _minutes = [];
  List<DropdownMenuItem> _days = [];
  List<DropdownMenuItem> _mouth = [];
  List<DropdownMenuItem> _years = [];

  List<DropdownMenuItem> get hours => _hours;
  List<DropdownMenuItem> get minutes => _minutes;
  List<DropdownMenuItem> get days => _days;
  List<DropdownMenuItem> get mouth => _mouth;
  List<DropdownMenuItem> get years => _years;
  List<Race> get races => races;

  void initalizetimedate() {
    final datetime = DateTime.now();
    _minutes = List.generate(60 - datetime.minute, (index) {
      return DropdownMenuItem(
        child: Text((datetime.minute + index).toString()),
        value: datetime.minute + index,
      );
    });
    _years = List.generate(10, (index) {
      return DropdownMenuItem(
        child: Text((datetime.year + index).toString()),
        value: datetime.year + index,
      );
    });
    _mouth = List.generate(12 - datetime.month, (index) {
      return DropdownMenuItem(
        child: Text((datetime.month + index).toString()),
        value: datetime.month + index,
      );
    });
    _days = List.generate(30 - datetime.day, (index) {
      return DropdownMenuItem(
        child: Text((datetime.day + index).toString()),
        value: datetime.day + index,
      );
    });
    notifyListeners();
  }

  void defaluttime() {}
}
