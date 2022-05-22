import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/screens/choose_word.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/navbar.dart';

class WhoChooseScreen extends StatefulWidget {
  const WhoChooseScreen({Key? key}) : super(key: key);

  @override
  State<WhoChooseScreen> createState() => _WhoChooseScreenState();
}

class _WhoChooseScreenState extends State<WhoChooseScreen> {
  final _formKey = GlobalKey<FormState>();
  late PlayersModel _players;

  @override
  void initState() {
    _players = Provider.of<PlayersProvider>(context, listen: false).getPlayers;
    super.initState();
  }

  void onSubmit(String startPlayer) {
    _formKey.currentState!.save();
    final bool isValide = _formKey.currentState!.validate();

    if (isValide) {
      Provider.of<PlayersProvider>(context, listen: false)
          .updatePlayersStart(startPlayer);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChooseWordScreen(),
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
            const Text('Qui choisi un mot ?', style: titleStyle),
            CustomButton(
              onAction: () => onSubmit(_players.player1),
              textButton: _players.player1,
            ),
            CustomButton(
              onAction: () => onSubmit(_players.player2),
              textButton: _players.player2,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
