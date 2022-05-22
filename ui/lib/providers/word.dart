import 'package:flutter/material.dart';

class WordProvider extends ChangeNotifier {
  String _word = '';

  String get getWord => _word;

  void updateWord(String word) {
    _word = word;
    notifyListeners();
  }
}
