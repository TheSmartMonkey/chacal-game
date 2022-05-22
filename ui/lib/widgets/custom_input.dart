import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int? maxLength;
  final Function? validator;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  valide(value) {
    if (value == null || value.isEmpty) {
      return 'Entre du text svp frère';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
          ),
          maxLength: maxLength,
          validator: (value) => validator ?? valide(value),
        ),
      ),
    );
  }
}
