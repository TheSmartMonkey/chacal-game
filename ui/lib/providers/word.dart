import 'package:flutter/material.dart';

class WordProvider extends ChangeNotifier {
  String _word = '';
  String _currentWord = '';

  String get getWord => _word;
  String get getCurrentWord => _currentWord;

  void updateWord(String word) {
    _word = word.toLowerCase();
    notifyListeners();
  }

  void updateCurrentWord(String currentWord) {
    _currentWord = currentWord.toLowerCase();
    notifyListeners();
  }

  void clearWord() {
    _word = '';
  }

  void clearCurrentWord() {
    _currentWord = '';
  }
}
