import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.onChanged,
    this.oscureText = false,
    required this.title,
  });

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
      keyboardType: TextInputType.emailAddress,
      obscureText: oscureText,
      onChanged: onChanged,
    );
  }
}
