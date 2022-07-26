import 'package:flutter_test/flutter_test.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';

import 'package:ui/screens/home.dart';
import 'package:ui/screens/who_choose.dart';

import '../test_utils/init_test.dart';
import '../test_utils/widget_test_utils.dart';

Future<void> main() async {
  testWidgets('Should create a game with players', (WidgetTester tester) async {
    // Given
    final playersProvider = PlayersProvider();
    final players = PlayersModel(
      player1: defaultPlayer1,
      player2: defaultPlayer2,
      start: defaultPlayer1,
    );

    // When
    await initAppWidgetTest(tester);

    // Then
    expectScreen(HomeScreen);
    expect(find.text('Choisir le nom des joueurs'), findsOneWidget);

    // Tap on play
    await buttonClick(tester, find.text('Jouer'));
    expect(playersProvider.getPlayers.toJson(), players.toJson());
    expectScreen(WhoChooseScreen);
    expect(find.text('Qui choisi un mot ?'), findsOneWidget);
  });
}
