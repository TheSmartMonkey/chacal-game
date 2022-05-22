import 'package:flutter/material.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/screens/who_choose.dart';
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
  final _player1 = TextEditingController(text: defaultPlayer1);
  final _player2 = TextEditingController(text: defaultPlayer2);

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
      _players = PlayersModel(
        player1: _player1.text,
        player2: _player2.text,
        start: _player1.text,
      );
      Provider.of<PlayersProvider>(context, listen: false)
          .updatePlayers(_players);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WhoChooseScreen(),
        ),
      );
    }
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
            const Text('Choisir le nom des joueurs', style: titleStyle),
            Column(
              children: [
                CustomInput(
                  controller: _player1,
                  label: 'Joueur 1',
                  hint: defaultPlayer1,
                ),
                CustomInput(
                  controller: _player2,
                  label: 'Joueur 2',
                  hint: defaultPlayer2,
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
