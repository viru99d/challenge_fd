import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.keyboardType = TextInputType.name,
    required this.onChanged,
    this.oscureText = false,
    required this.title,
  });

  final TextInputType keyboardType;
  final Function(String) onChanged;
  final bool oscureText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hoverColor: Colors.red,
        labelText: title,
        border: const OutlineInputBorder(),
      ),
      inputFormatters: keyboardType == TextInputType.number
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      keyboardType: keyboardType,
      obscureText: oscureText,
      onChanged: onChanged,
    );
  }
}
