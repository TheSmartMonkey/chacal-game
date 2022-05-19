import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ui/cors/constants.dart';
import 'package:ui/widgets/custom_button.dart';
import 'package:ui/widgets/custom_input.dart';

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
        body: Column(
          children: [
            FormBuilder(
              child: Column(
                children: [
                  CustomInput(formItem: CustomInputItem(hint: 'hint', name: 'name', onChanged: () {}), initialValue: const {})
                ],
              ),
            ),
            CustomButton(
              onAction: () => null,
              textButton: 'Jouer',
            ),
          ],
        ));
  }
}
