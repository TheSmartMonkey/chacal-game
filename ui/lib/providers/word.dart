import 'package:flutter/material.dart';

class WordProvider extends ChangeNotifier {
  String _word = '';
  String _currentWord = '';

  String get getWord => _word;
  String get getCurrentWord => _currentWord;

  void updateWord(String word) {
    _word = word;
    notifyListeners();
  }

  void updateCurrentWord(String currentWord) {
    _currentWord = currentWord;
    notifyListeners();
  }
}
