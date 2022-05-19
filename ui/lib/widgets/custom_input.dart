import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomInputItem {
  String hint;
  String? label;
  String name;
  Widget? icon;
  Function onChanged;
  bool isPassword;
  bool? isLabel;
  bool multiLine;
  String type = 'input';
  Function? validate;
  bool autofocus;
  bool Function()? onFieldSubmitted;
  bool? toShow;
  bool enable;

  CustomInputItem({
    required this.hint,
    this.label,
    required this.name,
    this.icon,
    required this.onChanged,
    this.isPassword = false,
    this.multiLine = false,
    this.validate,
    this.isLabel = true,
    this.autofocus = false,
    this.onFieldSubmitted,
    this.toShow = true,
    this.enable = true,
  });
}

class CustomInput extends StatefulWidget {
  final CustomInputItem formItem;
  final Map<String, dynamic> initialValue;

  const CustomInput({
    Key? key,
    required this.formItem,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = false;

  @override
  void initState() {
    setState(() {
      _obscureText = widget.formItem.isPassword;
    });
    super.initState();
  }

  dynamic _defaultValidate(value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    return null;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _iconButton(IconData icon) {
    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.black,
      onPressed: _toggle,
      icon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _validate = widget.formItem.validate ?? _defaultValidate;

    return FormBuilderTextField(
      key: Key(widget.formItem.name),
      initialValue: widget.initialValue.isNotEmpty
          ? widget.initialValue[widget.formItem.name]
          : '',
      name: widget.formItem.name,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        hintText: widget.formItem.hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelText:
            widget.formItem.isLabel == true ? widget.formItem.label : null,
        suffixIcon: widget.formItem.isPassword
            ? _obscureText
                ? _iconButton(Icons.remove_red_eye)
                : _iconButton(Icons.remove_red_eye_outlined)
            : null,
        errorMaxLines: 3,
        hintMaxLines: 3,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          gapPadding: 0.0,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // floatingLabelAlignment: FloatingLabelAlignment.center,
        contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        isDense: true,
      ),
      keyboardType: (widget.formItem.multiLine)
          ? TextInputType.multiline
          : TextInputType.text,
      minLines: (widget.formItem.multiLine) ? 3 : 1,
      maxLines: (widget.formItem.multiLine) ? null : 1,
      obscureText: _obscureText,
      validator: (value) => _validate(value),
      onChanged: (value) => widget.formItem.onChanged(value),
      autofocus: widget.formItem.autofocus,
      onEditingComplete: widget.formItem.onFieldSubmitted,
      enabled: widget.formItem.enable,
    );
  }
}
