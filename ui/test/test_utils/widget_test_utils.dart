import 'package:flutter_test/flutter_test.dart';

Future<void> wait(WidgetTester tester, {int seconds = 2}) async {
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: seconds));
}

Future<void> buttonClick(WidgetTester tester, Finder button) async {
  expect(button, findsOneWidget);
  await tester.tap(button);
  await wait(tester);
}

Future<void> scrollToItem(
  WidgetTester tester,
  Finder item,
  Type scrollBar,
) async {
  await tester.dragUntilVisible(
    item,
    find.byType(scrollBar),
    const Offset(-250, 0),
  );
  await wait(tester);
}

Future<void> inputEnterText(
  WidgetTester tester,
  Finder input,
  String text,
) async {
  expect(input, findsOneWidget);
  await tester.tap(input);
  await tester.enterText(input, text);
}

Future<void> dropdownSelectOption(
  WidgetTester tester,
  Finder dropdown,
  Finder dropdownItem,
) async {
  expect(dropdown, findsOneWidget);
  await tester.tap(dropdown);
  await wait(tester);
  await tester.tap(dropdownItem.last);
  await wait(tester);
}

void expectScreen(Type screen) {
  expect(find.byType(screen), findsOneWidget);
}
