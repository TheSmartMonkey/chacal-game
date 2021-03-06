import 'package:flutter/material.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/providers/number_of_tries.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/providers/word.dart';
import 'package:provider/provider.dart';
import 'package:ui/screens/home.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/navbar.dart';

class EndScreen extends StatefulWidget {
  final bool isWon;

  const EndScreen({Key? key, required this.isWon}) : super(key: key);

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  late String _word;

  @override
  void initState() {
    _word = Provider.of<WordProvider>(context, listen: false).getWord;
    super.initState();
  }

  void onSubmit() {
    Provider.of<PlayersProvider>(context, listen: false).clearPlayers();
    Provider.of<PlayersProvider>(context, listen: false).clearCurrentPlayer();
    Provider.of<WordProvider>(context, listen: false).clearWord();
    Provider.of<WordProvider>(context, listen: false).clearCurrentWord();
    Provider.of<NumberOfTriesProvider>(context, listen: false)
        .clearNumberOfTries();
    Provider.of<NumberOfTriesProvider>(context, listen: false)
        .clearCurrentNumberOfTries();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  Widget messageWidget() {
    if (widget.isWon) {
      return Column(
        children: [
          const Text('Félicitation !', style: titleStyle),
          Text('Le mot était $_word', style: titleStyle),
        ],
      );
    }
    return Column(
      children: [
        const Text('Dommage t nul !', style: titleStyle),
        Text('Le mot était $_word', style: titleStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavBar(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            messageWidget(),
            CustomButton(
              onAction: () => onSubmit(),
              textButton: 'Rejouer',
            ),
          ],
        ),
      ),
    );
  }
}
