import 'package:flutter_test/flutter_test.dart';

import 'package:ui/screens/home.dart';
import 'package:ui/screens/who_choose.dart';

import '../test_utils/widget_test_utils.dart';

void main() {
  group('Game tests', (() {
    testWidgets('Create a game test', (WidgetTester tester) async {
      // final mockObserver = MockNavigatorObserver();
      // Init app
      await initAppWidgetTest(tester);
      expectScreen(HomeScreen);

      // Verify title
      expect(find.text('Choisir le nom des joueurs'), findsOneWidget);
      // expect(find.text('1'), findsNothing);

      // Tap on play
      await buttonClick(tester, find.text('Jouer'));

      // verify(mockObserver.didPush(any, any));
      expectScreen(WhoChooseScreen);
      expect(find.text('Qui choisi un mot ?'), findsOneWidget);

      // Verify that our counter has incremented.
      // verify(MockPlayerProvider).called(1);
      expect(find.text('0'), findsNothing);
    });
  }));
}
