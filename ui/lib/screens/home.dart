import 'package:flutter/material.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/screens/choose_word.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/custom_input.dart';
import 'package:ui/widgets/navbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  PlayersModel _players = PlayersModel.empty();
  final _player1 = TextEditingController(text: 'player1');
  final _player2 = TextEditingController(text: 'player2');

  @override
  void dispose() {
    super.dispose();
    _player1.dispose();
    _player2.dispose();
  }

  void onSubmit() {
    _formKey.currentState!.save();
    final bool isValide = _formKey.currentState!.validate();

    if (isValide) {
      _players = PlayersModel(player1: _player1.text, player2: _player2.text);
      Provider.of<PlayersProvider>(context, listen: false)
          .updatePlayers(_players);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text(
      //           'Processing Data ${_players.player1} : ${_players.player2}')),
      // );
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChooseWordScreen()),
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
          children: [
            Column(
              children: [
                CustomInput(
                  controller: _player1,
                  label: 'Joueur 1',
                  hint: 'Laurent le BG',
                ),
                CustomInput(
                  controller: _player2,
                  label: 'Joueur 2',
                  hint: 'Elsa la BG',
                ),
              ],
            ),
            CustomButton(
              onAction: () => onSubmit(),
              textButton: 'Jouer',
            ),
          ],
        ),
      ),
    );
  }
}
