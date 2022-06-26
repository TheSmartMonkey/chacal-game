
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ui/main.dart';

import '../mocks/mocks.dart';
import 'widget_test_utils.dart';

Future<void> initAppWidgetTest(WidgetTester tester) async {
  await tester.pumpWidget(initApp());
  await wait(tester);
}

// MultiProvider initTestApp() {
//   return MultiProvider(
//     providers: [
//       ChangeNotifierProvider(
//         create: (_) => MockPlayerProvider(),
//       ),
//     ],
//     child: const MyApp(),
//   );
// }
