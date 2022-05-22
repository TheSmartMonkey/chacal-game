import 'package:flutter/material.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/providers/players.dart';
import 'package:ui/screens/choose_word.dart';
import 'package:ui/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlayersProvider(),
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
        '/chooseWord': (context) => const ChooseWordScreen(),
      },
    );
  }
}
