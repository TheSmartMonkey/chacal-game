import 'package:flutter/material.dart';

class NumberOfTriesProvider extends ChangeNotifier {
  int _numberOfTries = 50;
  int _currentNumberOfTries = 1;

  int get getNumberOfTries => _numberOfTries;
  int get getCurrentNumberOfTries => _currentNumberOfTries;

  void updateNumberOfTries(int numberOfTries) {
    _numberOfTries = numberOfTries;
    notifyListeners();
  }

  void incerementCurrentNumberOfTries(int currentNumberOfTries) {
    _currentNumberOfTries = currentNumberOfTries + 1;
    notifyListeners();
  }

  void clearNumberOfTries() {
    _numberOfTries = 50;
  }

  void clearCurrentNumberOfTries() {
    _currentNumberOfTries = 0;
  }
}
