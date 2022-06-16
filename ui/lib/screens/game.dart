import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/number_of_tries.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/providers/word.dart';
import 'package:ui/screens/end.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/custom_input.dart';
import 'package:ui/widgets/navbar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _formKey = GlobalKey<FormState>();
  late PlayersModel _players;
  late String _currentPlayer;
  late String _word;
  late String _currentWord;
  late int _numberOfTries;
  late int _currentNumberOfTries;
  final _selectedWord = TextEditingController(text: '');
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    _players = Provider.of<PlayersProvider>(context, listen: false).getPlayers;
    _currentPlayer =
        Provider.of<PlayersProvider>(context, listen: false).getCurrentPlayer;
    _word = Provider.of<WordProvider>(context, listen: false).getWord;
    _currentWord =
        Provider.of<WordProvider>(context, listen: false).getCurrentWord;
    _numberOfTries = Provider.of<NumberOfTriesProvider>(context, listen: false)
        .getNumberOfTries;
    _currentNumberOfTries =
        Provider.of<NumberOfTriesProvider>(context, listen: false)
            .getCurrentNumberOfTries;
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    _selectedWord.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onSubmit() {
    _formKey.currentState!.save();
    final bool isValide = _formKey.currentState!.validate();

    if (isValide) {
      Provider.of<PlayersProvider>(context, listen: false).updateCurrentPlayer(
        _players,
        _currentPlayer,
      );
      Provider.of<WordProvider>(context, listen: false).updateCurrentWord(
        _selectedWord.text,
      );
      _isWon();
    }
  }

  void _isWon() {
    Provider.of<NumberOfTriesProvider>(context, listen: false)
        .incerementCurrentNumberOfTries(_currentNumberOfTries);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (_selectedWord.text == _word) {
            return const EndScreen(isWon: true);
          } else if (_currentNumberOfTries + 1 == _numberOfTries) {
            return const EndScreen(isWon: false);
          }
          return const GameScreen();
        },
      ),
    );
  }

  int _remaningTries() {
    return _numberOfTries - _currentNumberOfTries;
  }

  @override
  Widget build(BuildContext context) {
    return NavBar(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('$_currentPlayer a toi de jouer', style: titleStyle),
            Text(
              'Essais restants:  ${_remaningTries().toString()}',
              style: titleStyle,
            ),
            Text(_currentWord, style: titleStyle),
            Column(
              children: [
                CustomInput(
                  controller: _selectedWord,
                  label: 'Choisir un mot',
                  hint: 'Chacal',
                  maxLength: 20,
                  onEditingComplete: () {
                    focusNode.nextFocus();
                    focusNode.nextFocus();
                    return true;
                  },
                ),
              ],
            ),
            CustomButton(
              onAction: () => onSubmit(),
              textButton: 'Valider',
              focusNode: focusNode,
            ),
          ],
        ),
      ),
    );
  }
}
