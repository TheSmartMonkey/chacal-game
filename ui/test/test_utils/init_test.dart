import 'package:flutter_test/flutter_test.dart';
import 'package:ui/main.dart';

import 'widget_test_utils.dart';

Future<void> initAppWidgetTest(WidgetTester tester) async {
  await tester.pumpWidget(initApp());
  await wait(tester);
}
