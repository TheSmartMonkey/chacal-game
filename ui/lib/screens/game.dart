import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
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
  final _selectedWord = TextEditingController(text: '');

  @override
  void initState() {
    _players = Provider.of<PlayersProvider>(context, listen: false).getPlayers;
    _currentPlayer =
        Provider.of<PlayersProvider>(context, listen: false).getCurrentPlayer;
    _word = Provider.of<WordProvider>(context, listen: false).getWord;
    _currentWord =
        Provider.of<WordProvider>(context, listen: false).getCurrentWord;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _selectedWord.dispose();
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

  List<Widget> enterWordWidget() {
    return [
      Text('$_currentPlayer a toi de jouer', style: titleStyle),
      Text(_currentWord, style: titleStyle),
      Column(
        children: [
          CustomInput(
            controller: _selectedWord,
            label: 'Choisir un mot',
            hint: 'Chacal',
          ),
        ],
      ),
      CustomButton(
        onAction: () => onSubmit(),
        textButton: 'Valider',
      ),
    ];
  }

  void _isWon() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (_selectedWord.text == _word) {
            return const EndScreen();
          }
          return const GameScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavBar(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: enterWordWidget(),
        ),
      ),
    );
  }
}
