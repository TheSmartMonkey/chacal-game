import 'package:flutter/material.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/providers/word.dart';
import 'package:ui/screens/choose_word.dart';
import 'package:ui/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:ui/screens/who_choose.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlayersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WordProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/who-choose': (context) => const WhoChooseScreen(),
        '/choose-word': (context) => const ChooseWordScreen(),
      },
    );
  }
}
