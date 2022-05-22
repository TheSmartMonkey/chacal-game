import 'package:flutter/material.dart';
import 'package:ui/models/players.dart';

class PlayersProvider extends ChangeNotifier {
  PlayersModel _players = PlayersModel.empty();

  PlayersModel get getPlayers => _players;

  void updatePlayers(PlayersModel players) {
    _players = players;
    notifyListeners();
  }
}
