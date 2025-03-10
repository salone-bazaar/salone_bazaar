import 'package:flutter/material.dart';

/// A reusable Flutter widget that provides dynamic validation for text fields.
///
/// This widget dynamically adjusts its validation behavior based on user interaction:
///
/// - Initially, it validates on unfocus [AutovalidateMode.onUnfocus], providing
///   immediate feedback when the user leaves the field.
/// - After losing focus for the first time, it switches to validate on [AutovalidateMode.onUserInteraction]
//    offering a more responsive experience as the user types.
/// - If [TextFormField.validator] method is called,  it switches to validate [AutovalidateMode.onUserInteraction].
///
/// This widget is designed to be extended to provide custom validation logic.
abstract class AutovalidatingTextField extends StatefulWidget {
  const AutovalidatingTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.autocorrect = false,
    this.enabled = true,
    this.onChanged,
    this.suffixIcon,
    this.initialValue,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final bool enabled;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  final Widget? suffixIcon;
  final bool autocorrect;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final Function(String)? onFieldSubmitted;

  String? validator(String? value);

  @override
  State<AutovalidatingTextField> createState() =>
      _AutovalidatingTextFieldState();
}

class _AutovalidatingTextFieldState extends State<AutovalidatingTextField> {
  final _valueNotifier = ValueNotifier(AutovalidateMode.onUnfocus);

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  String? _onValidation(String? value) {
    // Switch to onUserInteraction after the first validation
    if (_valueNotifier.value != AutovalidateMode.onUserInteraction) {
      _valueNotifier.value = AutovalidateMode.onUserInteraction;
    }
    return widget.validator(value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (context, autovalidateMode, child) => TextFormField(
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText,
        obscuringCharacter: widget.obscuringCharacter,
        autocorrect: widget.autocorrect,
        enabled: widget.enabled,
        controller: widget.controller,
        validator: _onValidation,
        onChanged: widget.onChanged,
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText.toUpperCase(),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
