import 'package:flutter_test/flutter_test.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';

import 'package:ui/screens/home.dart';

import '../../test_utils/init_test.dart';
import '../../test_utils/widget_test_utils.dart';

Future<void> main() async {
  group('Game screen', (() {
    testWidgets('Should create game screen', (WidgetTester tester) async {
      // Given
      // When
      await initAppWidgetTest(tester);

      // Then
      expectScreen(HomeScreen);
      expect(find.text('Choisir le nom des joueurs'), findsOneWidget);
    });

    testWidgets('Should press play init player provider',
        (WidgetTester tester) async {
      // Given
      final playersProvider = PlayersProvider();
      final players = PlayersModel(
        player1: defaultPlayer1,
        player2: defaultPlayer2,
        start: defaultPlayer1,
      );

      // When
      await initAppWidgetTest(tester);
      await buttonClick(tester, find.text('Jouer'));

      // Then
      expect(playersProvider.getPlayers.toJson(), players.toJson());
    });
  }));
}
