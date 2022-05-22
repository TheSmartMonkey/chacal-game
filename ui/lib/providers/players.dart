import 'package:flutter/material.dart';
import 'package:ui/models/players.dart';

class PlayersProvider extends ChangeNotifier {
  PlayersModel _players = PlayersModel.empty();
  String _currentPlayer = '';

  PlayersModel get getPlayers => _players;
  String get getCurrentPlayer => _currentPlayer;

  void updatePlayers(PlayersModel players) {
    _players = players;
    notifyListeners();
  }

  void updateCurrentPlayer(PlayersModel players, String currentPlayer) {
    if (currentPlayer == players.player1) {
      _currentPlayer = players.player2;
    } else {
      _currentPlayer = players.player1;
    }
    notifyListeners();
  }

  void updatePlayersStart(String startPlayer) {
    _players.start = startPlayer;
    notifyListeners();
  }

  void clearPlayers() {
    _players = PlayersModel.empty();
  }

  void clearCurrentPlayer() {
    _currentPlayer = '';
  }
}
