import 'package:flutter/material.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/widgets/button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: CustomButton(
          onAction: () => null,
          textButton: 'Commencer une nouvelle partie',
        ));
  }
}
