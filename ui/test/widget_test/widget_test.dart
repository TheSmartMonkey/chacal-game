import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/models/players.dart';
import 'package:ui/providers/players.dart';

import 'package:ui/screens/home.dart';
import 'package:ui/screens/who_choose.dart';

import '../test_utils/init_test.dart';
import '../test_utils/widget_test_utils.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([PlayersProvider])
Future<void> main() async {
  group('Game tests', (() {
    testWidgets('Create a game test', (WidgetTester tester) async {
      // Init app
      final mockObserver = MockPlayersProvider();
      final players = PlayersModel(
        player1: 'player1',
        player2: 'player2',
        start: 'player2',
      );
      mockObserver.updatePlayers(players);
      await initAppWidgetTest(tester);
      expectScreen(HomeScreen);

      // Verify title
      expect(find.text('Choisir le nom des joueurs'), findsOneWidget);
      // expect(find.text('1'), findsNothing);

      // Tap on play
      await buttonClick(tester, find.text('Jouer'));

      when(mockObserver.getPlayers).thenReturn(players);
      expect(mockObserver.getPlayers, equals(players));
      expectScreen(WhoChooseScreen);
      expect(find.text('Qui choisi un mot ?'), findsOneWidget);

      // Verify that our counter has incremented.
      // verify(MockPlayerProvider).called(1);
      expect(find.text('0'), findsNothing);
    });
  }));
}
