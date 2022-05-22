import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/providers/word.dart';
import 'package:ui/screens/game.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/custom_input.dart';
import 'package:ui/widgets/navbar.dart';

class ChooseWordScreen extends StatefulWidget {
  const ChooseWordScreen({Key? key}) : super(key: key);

  @override
  State<ChooseWordScreen> createState() => _ChooseWordScreenState();
}

class _ChooseWordScreenState extends State<ChooseWordScreen> {
  final _formKey = GlobalKey<FormState>();
  late PlayersModel _players;
  final _word = TextEditingController(text: '');

  @override
  void initState() {
    _players = Provider.of<PlayersProvider>(context, listen: false).getPlayers;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _word.dispose();
  }

  void onSubmit() {
    _formKey.currentState!.save();
    final bool isValide = _formKey.currentState!.validate();

    if (isValide) {
      Provider.of<WordProvider>(context, listen: false).updateWord(_word.text);
      Provider.of<PlayersProvider>(context, listen: false).updateCurrentPlayer(
        _players,
        _players.start,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GameScreen(),
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
            Text('${_players.start} commence', style: titleStyle),
            Column(
              children: [
                CustomInput(
                  controller: _word,
                  label: 'Choisir un mot',
                  hint: 'Chacal',
                ),
              ],
            ),
            CustomButton(
              onAction: () => onSubmit(),
              textButton: 'Valider',
            ),
          ],
        ),
      ),
    );
  }
}
