import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const Button({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF599BFF),
          foregroundColor: Colors.white,
          fixedSize: Size(259, 65)),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
